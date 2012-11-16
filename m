From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 16 Nov 2012 09:07:04 +0100
Subject: [PATCH 0/5] i2c-sh_mobile non-urgent changes
In-Reply-To: <5087C93F.6080601@renesas.com>
References: <5087C93F.6080601@renesas.com>
Message-ID: <20121116080704.GC8464@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 07:55:59PM +0900, Shinya Kuribayashi wrote:
> Hello,
> 
> This is the first batch to fix the i2c-sh_mobile driver.  As a first
> step, this comprises of the SCL optimization work and a simple fix to
> annoying spurious WAIT interrupt issue; in other words, this does not
> change tx/rx data handling logic.
> 
> This driver has an architectural problem with send/receive procedures
> and needs a fundamental overhaul.  I've been working on splitting into
> logical chunks, but not yet completed.
> 
> Patches are prepared against the vanilla v3.6.  I don't have a chance
> to give it a try with v3.6+ kernels myself, but tend to be optimistic
> about that.  I have been cooking these patches over a year, and they
> work perfectly fine with older kernels ..v3.4 so far.

Looks good to me, like the extensive patch descriptions. I am going to
apply it to for-next with patches 2+3 squashed, because after patch 2 we
would have a buggy state otherwise. Let me know if you are not okay with
that.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/3d2de104/attachment-0001.sig>
