From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Mar 2011 13:20:38 +0100
Subject: Support for ARM940T core Samsung S3C2510A MCU under Linux
In-Reply-To: <4D873890.5000302@snapgear.com>
References: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com>
	<201103192114.05164.arnd@arndb.de> <4D873890.5000302@snapgear.com>
Message-ID: <201103211320.38227.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 March 2011, Greg Ungerer wrote:
> > I could not find a git tree for uClinux that contains any recent
> > kernel. Does that exist?
> 
> I used to keep one on git.kernel.org for promoting non-architectural
> but non-MMU specific changes to mainline.
> 
> http://git.kernel.org/?p=linux/kernel/git/gerg/uclinux.git;a=summary
> 
> But I have had so few changes that fit in that category that I
> haven't used it in quite a while.

Yes, I found that tree when I looked last week. I was wondering
if there is any git or other repo for the files that are in
http://sourceforge.net/projects/uclinux/files/uClinux%20Stable/

The kernel sources there are newer than the ones from uclinux.git,
but I could not find a pointer to who maintains them or how.

	Arnd
