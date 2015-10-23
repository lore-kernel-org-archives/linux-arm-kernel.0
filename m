From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 12:15:31 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.3-rc
In-Reply-To: <alpine.LFD.2.20.1510231834520.24002@vaio.linux-foundation.org>
References: <6788509.osko4XNn1O@wuerfel>
 <alpine.LFD.2.20.1510231834520.24002@vaio.linux-foundation.org>
Message-ID: <11071677.x1l838PPrW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 18:41:32 Linus Torvalds wrote:
> On Thu, 22 Oct 2015, Arnd Bergmann wrote:
> > 
> > are available in the git repository at:
> > 
> >   git+ssh://gitolite at ra.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus
>
> Anyway, I've pulled using the sane externally visible verion, so no need 
> to resend, but check your scripting..

Found the problem, I was actually running 'git request-pull' from a
different machine than I normally use, and that didn't have the
URL set up right. Sorry about the mess.

	Arnd
