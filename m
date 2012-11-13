From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 13 Nov 2012 18:20:42 +0530
Subject: [PATCHv3 0/7] i2c: omap: updates
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAM=Q2cs2A7iwCLaGP90OFbecYbem_kLxEVY+xKS86un2QYRDAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 5:53 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>
> Does the followiing
> - Make the revision a 32- bit consisting of rev_lo amd rev_hi each
> of 16 bits.
>
> - Also use the revision register for the erratum i207.
> - Refactor the i2c_omap_init code.
>
> Adds a patch to remove the hardcoding sysc register. Instead
> read register ,reset and then writeback the read value.
>
> Also more cleanup is possible will check on that subsequently.
>
> Previous discussions can be found
> http://www.spinics.net/lists/linux-omap/msg81265.html
>
>
> Tested on OMAP4430sdp  ,4460 ,omap3630 ,3430 and omap2430.
>
> For omap2 testing the below patch was used
> [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3 set
>
If there are no further comments can this be considered for next.

Thanks and Regards,
