From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 10:44:01 -0700
Subject: [GIT PULL] ARM: mvebu: dt for v4.4 (#2)
In-Reply-To: <87r3kug0ig.fsf@free-electrons.com>
References: <87r3kug0ig.fsf@free-electrons.com>
Message-ID: <20151022174401.GC31793@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 07:56:55PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second pull request for dt for mvebu for v4.4.
> 
> Gregory
> 
> The following changes since commit 9b24a35cb59888194706825b9c5ac550b0880277:
> 
>   ARM: mvebu: modify Orion and Kirkwoord crypto compatible strings (2015-10-09 17:08:02 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.4-2
> 
> for you to fetch changes up to 6b61f2497852b7d27e1c024d966c09defbf99948:
> 
>   ARM: mvebu: set SW polling as SDHCI card detection on A388-GP (2015-10-16 19:17:57 +0200)
> 
> ----------------------------------------------------------------
> mvebu dt for 4.4 (part 2)
> 
> - Add support for severals Armada-370-based Seagate NAS
> - Fix Ready NAS device tree
> - Modify SDHCI binding for A388-GP allowing using it on old and new
>   version of the board

While this introduces the Seagate Personal Cloud DT that has the binding of the
patch I just commented on, the comments were around code and not binding, and
I'm OK with the binding part.

So, I've merged this branch as it is. Thanks!


-Olof
