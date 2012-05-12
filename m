From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 12 May 2012 20:10:50 +0200
Subject: [PATCHv9 00/10] I2C fixes
In-Reply-To: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120512181050.GB28973@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 08:02:05PM +0530, Shubhrajyoti D wrote:
> 
> The patch series does the following
> 
> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> - In case of i2c remove register access was done without any
>  get_sync fix the same.
> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> - Prevents the XDUF flag to be set if the underflow condition is not met.
> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
>  use the unique id instead as the section number in the recent errata
>  docs has changed.
> 
> v9:
> Fix the comments from Wolfram Sang

Patch 2 has my comment not addressed, so I stopped reviewing. It is
probably more helpful (and easier for me, too) if you do a changelog per
patch (and not of the whole series), then you can immediately see if
that specific changelog matches the current patch. 'git send-email
--annotate' might be helpful here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120512/c4db5ea4/attachment.sig>
