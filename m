From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Feb 2013 21:00:01 +0100
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <CAKGA1bmqdCiocc_O6hU3ym6uJ-bAjwKMNrt43Qs_dkjEGpX-KQ@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130222055203.GB27371@S2101-09.ap.freescale.net>
 <CAKGA1bmw+CzBDLHty1+L1VdeWLgkPpLSLpGKBJEeQj-ByyzicA@mail.gmail.com>
 <20130227074404.GD1906@pengutronix.de>
 <CAKGA1bmqdCiocc_O6hU3ym6uJ-bAjwKMNrt43Qs_dkjEGpX-KQ@mail.gmail.com>
Message-ID: <20130227200001.GM1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 12:16:20PM -0600, Matt Sealey wrote:
> On Wed, Feb 27, 2013 at 1:44 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Feb 27, 2013 at 12:51:56AM -0600, Matt Sealey wrote:
> 
> I do notice that, what I'm a little perturbed by is that it doesn't
> seem to improve the situation (the amount of work required to use and
> VERIFY the values in each macro - on the assumption that any of them
> could be wrong and cross-check them with the schematics, the board
> designer if necessary, and then put them in a device tree as known
> working. Not all of the data files used in PCB design packages
> actually match the docs anyway so there are some cross-checks against
> yet another Freescale design database. If I asked someone here to go
> find the pin settings for USDHC2 on a board we have, they would first
> have to figure out which pad this was coming out of, go to the manual,
> find the signals that exit on that pad, look at the IOMUX, cross check
> it with some example code and the FSL IOMUX tool... pre-processing and
> using macros doesn't make that any easier until we have a single,
> fixed, totally verified and unchangeable set of macros which will
> cover all the usual cases. If the intent is that we just glob in 2500
> pin definitions at the start and "hope" that someone "eventually"
> notices any errors.. this is not normal in embedded design.

If the macro is unused then who cares about the bugs in it? If on the
other hand it is used, then people will notice the bugs quite fast and
will fix them. If you don't like the macros, then don't use them. If
you have a better idea how the macros should look like, send patches.

Please try and make your point in the amount of text I quoted above,
preferably even shorter, because that's the maximum amount of text I
think most people are willing to read per mail. The shorter you write
the more people will read your mails up to the end and maybe react to
it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
