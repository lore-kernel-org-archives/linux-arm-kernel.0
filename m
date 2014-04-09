From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Apr 2014 11:32:52 +0200
Subject: [RFC 0/3] future of gemini platform
In-Reply-To: <CACRpkdYuxJ2CWQGDCWx+4Yp2r3=OVunyx2kfTyBKay43jaHvnA@mail.gmail.com>
References: <1357310500-19848-1-git-send-email-arnd@arndb.de>
 <1357310500-19848-5-git-send-email-arnd@arndb.de>
 <CACRpkdYuxJ2CWQGDCWx+4Yp2r3=OVunyx2kfTyBKay43jaHvnA@mail.gmail.com>
Message-ID: <8341946.9jZiCPfkKB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014 10:40:48 Linus Walleij wrote:
> On Fri, Jan 4, 2013 at 3:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Arnd Bergmann (3):
> >   ARM: gemini: get platform to build again
> >   ARM: gemini: remove platform support
> >   ARM: remove fa526 CPU support
> 
> Arnd: I suggest you rebase and apply this series, sans the FA526
> removal as I hear it may now be used on the Moxart.
> 
> I patched the generic time code for gemini in october last year
> and noone has yet bothered to even test it!

I guess you mean just the middle patch then? The first one
was actually applied.

On the other hand, I did make a patch now to enable multiplatform
support for gemini that I was planning to send for review.

Florian, what is the status of gemini in openwrt? From what I can
tell, it's stuck at linux-3.9 [1], which is probably why nobody has
tested Linus' timer code. It's not clear if anyone is still interested
in it, but I also don't see a reason why any of the patches in
the openwrt repository couldn't just get merged (with some trivial
changes in a few cases).

	Arnd

http://git.openwrt.org/?p=openwrt.git;a=history;f=target/linux/gemini/patches;h=b58795e82765935eba3f001c39c8e4ca8c3c549e;hb=HEAD
