From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jan 2016 14:49:39 +0100
Subject: [PATCH v7 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
In-Reply-To: <CAK7LNAQkfSqYs7jJ6Zn0HS6FBRcXbonmNZ0eV_QS0mYeS8adbA@mail.gmail.com>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
 <2230140.n6kW8LSSaP@wuerfel>
 <CAK7LNAQkfSqYs7jJ6Zn0HS6FBRcXbonmNZ0eV_QS0mYeS8adbA@mail.gmail.com>
Message-ID: <4241029.3TORj3rutI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 January 2016 19:54:08 Masahiro Yamada wrote:
> 2015-05-13 16:48 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 13 May 2015 16:00:21 Masahiro Yamada wrote:
> >
> > No worries, if you are unsure you can always ask us on the mailing
> > list or on the #armlinux channel on irc.freenode.net.
> >
> > If you have more than a few patches at once, we'd always appreciate
> > a pull request, for a couple of patches, emails to arm at kernel.org plus
> > linux-arm-kernel are fine as well.
> >
> > When you do pull requests, please split them up according to larger
> > topics, e.g. send dts changes separately from code changes, and
> > separate bug fixes, cleanups and new feature support.
> >
> > Often when you add a new driver, that will require sending the driver
> > code to a subsystem maintainer, and the dts changes to us. If everything
> > goes well, your DT bindings are both forward and backward compatible,
> > so they can get merged independently. If you ever have interdependencies
> > between them, talk to us first so we can find a solution.
> >
> > For sending pull requests, it would be good to have a gpg key that
> > is signed by other well-known kernel developers. If you have such
> > a key, you can also request a kernel.org account to host a git tree
> > there, or you can host a git tree somewhere on your company's domain.
> > A public hosting service like github is not as good for us, but we
> > can deal with it when you are still ramping up your infrastructure.
> > Let me know if you need help finding kernel developers to sign your key.
> 
> 
> About 7 months have passed since I became a sub-arch maintainer (ARM/UniPhier),
> and I am hoping now I deserve to have the gpg key thing you mentioned.
> 
> Could you help me get a key and a kernel.org account to host a git tree?
> 
> It would make it easier to get SoC-specific things in
> without loading you and Olof.

Getting the kernel.org account should be straightforward once you have
a signed gpg key, see the description in https://www.kernel.org/category/faq.html

If you don't have a gpg key yet, please generate one with 4096 bits
keylength now. It's good to get as many signatures as possible from people
that already have signatures by other kernel contributors. The complication
is that you anyone who signs your key needs to verify your identity, otherwise
the signature method would not be helpful.

I have added three people to Cc that might be able you here: I understand that
you live in Osaka, so Simon Horman would be physically the closest in Kobe.
Takahiro Akashi works at Socionext in Tokyo, and I think you already know Akira
Tsukamoto.

If you happen to be in the same place with one of them, or maybe they have
already signed the key of someone close by.

	Arnd
