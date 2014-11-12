From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 12 Nov 2014 16:51:01 +0100
Subject: [PATCH v4] i2c/at91: adopt pinctrl support
In-Reply-To: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
References: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141112155101.GC4031@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 09:55:52AM +0800, Wenyou Yang wrote:
> Amend the at91 i2c pin controller to optionally take a pin control
> handle and set the state of the pins to:
> - "default" on boot and resume.
> - "sleep" on suspend().
> 
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/1f5fa941/attachment.sig>
