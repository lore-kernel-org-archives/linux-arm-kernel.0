From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 27 Dec 2013 05:27:47 +0100
Subject: [PATCH V2 3/5] arm: shmobile: r7s72100: add nodes for i2c
 controllers to dtsi
In-Reply-To: <1387402321-21866-4-git-send-email-wsa@the-dreams.de>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-4-git-send-email-wsa@the-dreams.de>
Message-ID: <20131227042747.GB6161@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 10:31:59PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> I decided to put the pinmuxing into the dtsi file since there is only
> one pinmux posiibility which one probably wants to have when using the
> bus.
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Magnus Damm <damm@opensource.se>

Simon, I think you could pull in these patches, too. My series does not
really depend on the pinctrl stuff. I2C pins are function group 1 and
thus activated by default if the bootloader doesn't do weird things.
Actually, I coded the PFC stuff after the driver was finished :)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131227/e80a68ff/attachment-0001.sig>
