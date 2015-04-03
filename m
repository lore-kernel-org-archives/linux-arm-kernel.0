From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 14:54:45 -0700
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.1 (round 3)
In-Reply-To: <551D03AE.4010105@free-electrons.com>
References: <551D03AE.4010105@free-electrons.com>
Message-ID: <20150403215445.GR23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 10:54:06AM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the third pull request for dt for mvebu for v4.1.
> By the way you didn't pull the second one I sent 10 days
> ago. If you prefer I can delete the tags mvebu-dt-4.1-2
> and mvebu-dt-4.1-3. And create a new one gathering the
> content of the both.
> 
> Gregory
> The following changes since commit 7776ab70d75ff9857343e44e428744d81c30ce1b:
> 
>   ARM: mvebu: armada-385-ap: Enable USB3 port (2015-03-18 11:55:49 +0100)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.1-3
> 
> for you to fetch changes up to 292a3546b9eb20bf5a292f4e55dd1a027424669f:
> 
>   ARM: mvebu: Conform L2CC node with ePAPR specification by adding cache-level (2015-03-19 11:07:47 +0100)
> 
> ----------------------------------------------------------------
> mvebu dt changes for v4.1 (part #3)
> 
> These changes have no influence on the kernel behavior (except
> removing a warning message), but they allow to have a better
> representation of the hardware.
> 
> - conform L2CC node with ePAPR specification by adding cache-level
> - remove cpuclk resources overlapping coredivclk registers on Armada XP
> 


Thanks, merged.

-Olof
