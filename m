From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 6 May 2014 13:13:46 +0200
Subject: [PATCH 1/2] of: add bq and radxa vendor prefixes
In-Reply-To: <CABuKBe+fFCU2__rEHfiU+XPQwKE613VBxQ4=8xiA3PXQkBiMDQ@mail.gmail.com>
References: <1398973835-26303-1-git-send-email-b.galvani@gmail.com>
 <2225372.rvnmuAdhHE@phil>
 <CABuKBe+fFCU2__rEHfiU+XPQwKE613VBxQ4=8xiA3PXQkBiMDQ@mail.gmail.com>
Message-ID: <20140506111345.GB22196@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 04, 2014 at 02:57:52PM +0200, Matthias Brugger wrote:
> 2014-05-02 1:32 GMT+02:00 Heiko St?bner <heiko@sntech.de>:
> > Hi Beniamino,
> >
> > Am Donnerstag, 1. Mai 2014, 21:50:34 schrieb Beniamino Galvani:
> >> Add new vendor prefixes for:
> >>
> >>     * bq, a company that sells multimedia devices and 3D printers
> >
> > bq is actually only a brandname. The company itself is "Mundo Reader S.L.".
> > I'm not sure what the actual policy is concerning the vendor prefix, i.e. if it
> > should use the visible brand name or the actual company name.
> >
> > I.e. another possibility would be to add the vendor prefix
> >         mundoreader     Mundo Reader S.L.
> > and name the currie
> >         mundoreader,bq-curie2
> 
> I think we should stick to the brand name, as this is the name people know.

Personally I don't have a strong preference, so either of the two.

Beniamino

> 
> >
> >
> > Heiko
> >
> >>     * Radxa, manufacturer of ARM boards
> >>
> >> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/vendor-prefixes.txt |    2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> >> abc3080..6f8177c 100644
> >> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> @@ -21,6 +21,7 @@ atmel       Atmel Corporation
> >>  auo  AU Optronics Corporation
> >>  avago        Avago Technologies
> >>  bosch        Bosch Sensortec GmbH
> >> +bq   bq
> >>  brcm Broadcom Corporation
> >>  buffalo      Buffalo, Inc.
> >>  calxeda      Calxeda
> >> @@ -98,6 +99,7 @@ powervr     PowerVR (deprecated, use img)
> >>  qca  Qualcomm Atheros, Inc.
> >>  qcom Qualcomm Technologies, Inc
> >>  qnap QNAP Systems, Inc.
> >> +radxa        Radxa
> >>  raidsonic    RaidSonic Technology GmbH
> >>  ralink       Mediatek/Ralink Technology Corp.
> >>  ramtron      Ramtron International
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> -- 
> motzblog.wordpress.com
