From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 5 Jun 2016 17:54:00 +0200 (CEST)
Subject: [PATCH RFT 2/4] ARM: dts: imx28-eukrea-mbmx28lc: add missing
 reg properties
In-Reply-To: <CAOMZO5DqYV97M+heNaehqFCTEiYnYKRqCfiF0FMxzqEvw-gkZw@mail.gmail.com>
References: <1465134666-13459-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DqYV97M+heNaehqFCTEiYnYKRqCfiF0FMxzqEvw-gkZw@mail.gmail.com>
Message-ID: <1527550523.279555.c2b71a89-24ac-4970-b99e-c80b6a2e1ba0.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 5. Juni 2016 um 16:00 geschrieben:
> 
> 
> On Sun, Jun 5, 2016 at 10:51 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This patch adds the missing reg properties for the regulator nodes
> > in order to fix the dtc warnings.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >  arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> > b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> > index 8859474..581e85f 100644
> > --- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> > +++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> > @@ -84,6 +84,7 @@
> >
> >                 reg_3p3v: regulator at 0 {
> >                         compatible = "regulator-fixed";
> > +                       reg = <0>;
> 
> The proper fix here would be to remove "@0" instead.

in this case many other mxs boards are wrong.
