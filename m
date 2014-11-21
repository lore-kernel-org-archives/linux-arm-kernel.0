From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 15:23:07 -0800
Subject: [GIT PULL v2] ARM: OMAP2+: some more hwmod & clock patches for
 v3.19
In-Reply-To: <alpine.DEB.2.02.1411211917280.9204@utopia.booyaka.com>
References: <alpine.DEB.2.02.1411211917280.9204@utopia.booyaka.com>
Message-ID: <20141121232307.GY7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [141121 11:19]:
> Hi Tony
> 
> The following changes since commit 79005fbd3e1d671d08c45c9140ee9826efdc367c:
> 
>   ARM: OMAP2+: hwmod: drop unnecessary list initialization (2014-11-13 09:36:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19/omap-b2
> 
> for you to fetch changes up to 1f074f996482220f90fbe3dcfafeb3db46ec748a:
> 
>   Merge branch 'adc-support-v3.19' into omap-b-for-v3.19 (2014-11-21 11:05:05 -0700)
> 
> ----------------------------------------------------------------
> Several more OMAP patches targeted for v3.19. They include:
> 
> - OMAP4/5: DSS hwmod cleanup patches from Tomi Valkeinen.
> - DRA7xx: hwmod data support for UARTs 7 through 10.
> - AM43xx: hwmod data support for the onboard ADC.
> 
> Basic build, boot, and PM test reports are here:
> 
> http://www.pwsan.com/omap/testlogs/omap-b-for-v3.19/20141121110550/
> 
> Note that I cannot test the DRA7xx or AM43xx patches, since I do not have
> these boards.

Pulling into omap-for-v3.19/soc thanks.

Tony
