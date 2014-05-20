From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 21:58:00 -0700
Subject: [GIT PULL] ARM: mvebu: SoC orion5x DT conversion for v3.16
In-Reply-To: <20140508180249.GL12708@titan.lakedaemon.net>
References: <20140508180249.GL12708@titan.lakedaemon.net>
Message-ID: <20140520045800.GF18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 02:02:49PM -0400, Jason Cooper wrote:
> guys,
> 
> This is a great series by Thomas that gets orion5x well on it's way to
> happy devicetree land. :)
> 
> This series crosses quite a few subdirectories, but the changes are
> isolated to orion5x-specific files and legacy platform code.  iow, any
> conflicts are going to be internal to mvebu.  This branch has been up in
> -next for over a week without problems.
> 
> I chose to keep the series together to keep orion5x bootable during
> bisection.  If you have any trouble with this branch, please let me
> know.

No problem at all. Excellent to see the platform being converted over.

> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-orion5x-3.16
> 
> for you to fetch changes up to 19e00f20e90e349cdeef3d7b63e6179215c9ff9d:
> 
>   ARM: orion: remove no longer needed gpio DT code (2014-04-26 19:45:28 +0000)

Merged into next/soc.



-Olof
