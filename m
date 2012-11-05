From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 10:10:09 +0200
Subject: [PATCH v2 0/7] I2C patches for v3.8 merge window
In-Reply-To: <1351167915-15079-1-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
Message-ID: <20121105081009.GA2490@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 03:25:08PM +0300, Felipe Balbi wrote:
> Hi,
> 
> here's another series for OMAP I2C driver. There are a few cleanups
> and one very nice new feature: we can now report how many bytes
> we transferred until NACK.
> 
> Note that the implemementation for OMAP-I2C turned out to be a
> little more complex then I expected, mainly because of the way
> I2C_CNT register behaves and because of the very buggy register
> usage on that driver.
> 
> I have boot tested all patches on beagle xM (3630) and pandaboard
> rev A3 (4430), will send boot-logs if anyone wants to see.
> 
> All patches are available at [1] if anyone wants an easy way to
> test the patches.

Wolfram, patches 1-5 are ok to apply, we just need to rework patches 6
and 7 so drivers can report how many bytes managed to be transferred.
None of these patches cause any known regressions.

let me know if you want me to resend only the 5 patches which should be
applied.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/49c4a6f5/attachment.sig>
