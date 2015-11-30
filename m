From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Nov 2015 18:27:04 +0100
Subject: [PATCH v2 3/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
In-Reply-To: <1446118467-26453-3-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-3-git-send-email-nicola@corna.info>
Message-ID: <20151130172704.GD9554@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:25PM +0100, Nicola Corna wrote:
> As reported here
> http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
> and confirmed here
> https://www.raspberrypi.org/forums/viewtopic.php?p=146272
> the BCM2835 has a hardware bug in its i2c module which prevents a correct
> clock stretching. This patch adds the I2C_AQ_NO_CLK_STRETCH quirk flag
> to i2c-bcm2835.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>

I put the above links into the code as comments, reworded the commit
message a little and applied it to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/eee0f79a/attachment.sig>
