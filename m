From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 5 Aug 2016 19:45:57 +0200
Subject: [PATCH 0/2] Drop last two remaining omap3 legacy board files
In-Reply-To: <1465987689-14812-1-git-send-email-tony@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
Message-ID: <20160805174557.GA27448@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 15, 2016 at 03:48:07AM -0700, Tony Lindgren wrote:
> Here are two patches to drop the last remaining omap3 legacy boot
> files. We have device tree based booting working for these boards,
> and the legacy booting has been mostly kept around to validate
> against regressions.
> 
> Let's not touch the rest of the platform init code until around
> v4.9 so we can revert these two patches if needed.
>
> Cheers,
> 
> Tony
> 
> Tony Lindgren (2):
>   ARM: OMAP2+: Drop legacy board file for n900
>   ARM: OMAP2+: Drop legacy board file for LDP

I wonder what happened to these patches. I see, that you have a
omap-for-v4.8/legacy branch, which contains them. But as far as I
can see its not in linux-next and it was not included in the ARM
pull request.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160805/333d6a68/attachment.sig>
