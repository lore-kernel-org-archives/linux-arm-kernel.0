From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Sep 2014 15:08:59 +0200
Subject: [PATCH 1/9] ARM: dts: vf610: Add system reset controller (SRC)
In-Reply-To: <45f7af8b2dbe11967bb2ad87826b934c@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
 <2ca1cf3732a00512fa19b6118f9fb30aba014deb.1411404079.git.stefan@agner.ch>
 <CACRpkdbryJVW9e9N5+f3rWEGZ2YvLPJsvBtNSa9nPJpLVXhm0g@mail.gmail.com>
 <45f7af8b2dbe11967bb2ad87826b934c@agner.ch>
Message-ID: <1411650539.5671.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Am Mittwoch, den 24.09.2014, 18:41 +0200 schrieb Stefan Agner:
> Am 2014-09-24 11:16, schrieb Linus Walleij:
> > On Mon, Sep 22, 2014 at 7:09 PM, Stefan Agner <stefan@agner.ch> wrote:
> > 
> >> Add device tree property for system reset controller.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > 
> > Are there already device tree bindings for SRC and GRC?
> 
> Yes there are used in the i.MX6 world for instance, see imx6qdl.dtsi.
> The SRC also has quite generic documentation, however, the GPC module
> currently lacks documentation...

A patch that adds GPC binding documentation is part of this i.MX6 power
domain series:

http://www.spinics.net/lists/devicetree/msg48454.html

regards
Philipp
