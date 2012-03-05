From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Mar 2012 17:02:37 +0000
Subject: [GIT PULL 0/6] Tegra branches for 3.4
In-Reply-To: <CAOesGMgahK_wkM1PGb55D1gEzbYfJVQKO_XSqMPbw5wTP09Fag@mail.gmail.com>
References: <1330892042-32065-1-git-send-email-olof@lixom.net>
 <CAOesGMgahK_wkM1PGb55D1gEzbYfJVQKO_XSqMPbw5wTP09Fag@mail.gmail.com>
Message-ID: <201203051702.38188.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 March 2012, Olof Johansson wrote:
> On Sun, Mar 4, 2012 at 12:13 PM, Olof Johansson <olof@lixom.net> wrote:
> > Hi Arnd,
> >
> > Below are the 6 pull requests for Tegra platforms for 3.4. This is also
> > likely my last merge request for tegra material (besides possibly some
> > stray patches between now and the merge window), since I am handing off
> > main maintainership to Stephen Warren for the next merge window.
> >
> > Each branch is documented in the tag (they are all tag pull requests), as
> > well as in the emails below. Nothing too controversial.
> 
> Oh, I did forget to mention one added dependency: The soc-drivers
> branch has a dependency on Grant's irq_domain branch -- not for
> merging but for building.

Yes, I saw that in the tag description. I had included it in the tegra/soc-drivers
branch, but not in the next/drivers branch, which I did now.

	Arnd
