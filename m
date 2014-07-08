From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Jul 2014 22:28:47 -0700
Subject: [GIT PULL V2] ARM: mvebu: SoC changes for v3.17
In-Reply-To: <20140701121119.GD23978@titan.lakedaemon.net>
References: <20140627124655.GF23978@titan.lakedaemon.net>
 <20140701121119.GD23978@titan.lakedaemon.net>
Message-ID: <20140708052847.GF28931@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 08:11:19AM -0400, Jason Cooper wrote:
> Guys,
> 
> Here's most of the SoC changes for mvebu so far.  It's looking to be a
> slow cycle for us this time around (famous last words ;-) ).
> 
> The only unusual item here is the setup file for the kirkwood netxbig
> board.  Andrew is working on a DT binding for the LEDs, but it is
> non-trivial.  By accepting this now, we can delete mach-kirkwood/, which
> is a good thing. :)  I hope to see patches from Andrew on this soon.
> 
> As usual, based on v3.16-rc1, no dependencies, been in -next several
> days.
> 
> Changes for V2: move three patches out of mvebu/soc and into mvebu/fixes
> for inclusion in v3.16.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17

Merged.


-Olof
