From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 10 Feb 2013 19:16:27 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP4: PM fixes and AESS integration for 3.9
In-Reply-To: <alpine.DEB.2.00.1302101814390.2672@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302081812040.28008@utopia.booyaka.com>
 <20130210170849.GM4801@atomide.com>
 <alpine.DEB.2.00.1302101814390.2672@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1302101915220.2672@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Feb 2013, Paul Walmsley wrote:

> Thanks.  Looks like the AESS hwmod used a leaf clock that was removed by 
> one of the earlier cleanup patches.  Will fix and send a new pull request 
> for this series based on what's now in the arm-soc omap/pm branch 
> (0e084c9c843320995b0e219f02880f910d439b37).

Just sent the updated pull request.  Turns out that it was possible to 
base it on v3.8-rc6.  Hopefully that should fix the boot regression; 
please let me know if that turns out not to be the case.


- Paul
