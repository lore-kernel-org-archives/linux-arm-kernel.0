From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 14:13:57 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.7 (#2)
In-Reply-To: <13443700.NUC16SCx6V@wuerfel>
References: <87pot8sct4.fsf@free-electrons.com> <13443700.NUC16SCx6V@wuerfel>
Message-ID: <2554522.hzQidgmgjq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 14:05:48 Arnd Bergmann wrote:
> On Friday 29 April 2016 16:35:19 Gregory CLEMENT wrote:
> > mvebu defconfig for 4.7 (part 2)
> > 
> > - enable AP806 and CP110 syscon driver in arm64 defconfig
> > 
> > 
> 
> Merged into next/defconfig, thanks!
> 

I ended up undoing the merge before I pushed it out to the git server
as I noticed you have both arm and arm64 changes in there.

Can you still split up the branch in two?

	Arnd
