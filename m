From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Dec 2010 16:17:53 -0700 (MST)
Subject: [PATCH v2 0/6] OMAP: hwmod core fix and cleanup for 2.6.38
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012211615130.1446@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010, Benoit Cousson wrote:

> Here is a small series that just remove the omap_hwmod_mutex
> and move functions not needed at runtime to the __init section.
> 
> It fix as well a bug discovered during the on-going hwmod migration
> of device that does have a functional clock external (mcpdm).
> 
> It extends as well the fix Kevin did for wakeup for OMAP4 IP with
> smart idle with wakeup support. 
> 
> The series is based on my for_2.6.38/hwmod_data branch and is available 
> here: git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod
> 
> Tested on sdp4430 ES2.0 with omap2plus_defconfig.
> It still requires some test on OMAP3 and OMAP2.
> 
> Thanks to Seb Guiriec for testing the SIDLE_SMART_WKUP fix.

Thanks, this series has been created as the 'hwmod_c_2.6.38' branch on 
git://git.pwsan.com/linux-2.6.

It's been added to the integration tree as tag 
'integration-2.6.38-20101221-003' at 
git://git.pwsan.com/linux-integration.


- Paul
