From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 15:03:56 +0100
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <CAL_JsqKYR1aujNhOASivsg-ED6xDPCsSCcGVnQn5vy4sD1PhAQ@mail.gmail.com>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqKYR1aujNhOASivsg-ED6xDPCsSCcGVnQn5vy4sD1PhAQ@mail.gmail.com>
Message-ID: <9768087.NlERCxKjPM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 March 2014 08:59:32 Rob Herring wrote:
> On Wed, Mar 26, 2014 at 4:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >  menu "RealView platform type"
> >         depends on ARCH_REALVIEW
> >
> > +config REALVIEW_DT
> > +       bool "Support RealView(R) Device Tree based boot"
> > +       select ARM_GIC
> > +       select USE_OF
> > +       select SOC_BUS
> > +       select MFD_SYSCON
> 
> Sort.
> 
> This will probably need to be coordinated with Arnd's cpu selection rework.

Ignore my cpu selection patches here, we'll do those later.


	Arnd
