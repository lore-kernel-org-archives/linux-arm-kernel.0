From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 5 Mar 2013 13:45:46 +0000
Subject: [PATCH v2 1/4] spi/davinci: add DT binding documentation
In-Reply-To: <5135F316.6030007@ti.com>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
 <1362401955-9616-2-git-send-email-prakash.pm@ti.com>
 <6918845.dALXSKksQd@wuerfel>
 <A73F36158E33644199EB82C5EC81C7BC3EA4854E@DBDE01.ent.ti.com>
 <5135F316.6030007@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4856F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 18:58:54, Nori, Sekhar wrote:
> 
> 
> On 3/5/2013 6:26 PM, Manjunathappa, Prakash wrote:
> > Hi Arnd,
> > 
> > On Mon, Mar 04, 2013 at 21:59:16, Arnd Bergmann wrote:
> >> On Monday 04 March 2013 18:29:12 Manjunathappa, Prakash wrote:
> >>> diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
> >>> new file mode 100644
> >>> index 0000000..a62d7a8
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
> >>> @@ -0,0 +1,51 @@
> >>> +Davinci SPI controller device bindings
> >>> +
> >>> +Required properties:
> >>> +- #address-cells: number of cells required to define a chip select
> >>> +	address on the SPI bus. Should be set to 1.
> >>> +- #size-cells: should be zero.
> >>> +- compatible:
> >>> +	- "ti,dm644x-spi" for SPI used similar to that on DM644x SoC family
> >>> +	- "ti,da8xx-spi" for SPI used similar to that on DA8xx SoC family
> >>
> >> In general, you should avoid wildcards in "compatible" properties.
> >> Better use the number of the first chip that introduced the specific
> >> version of the device.
> >>
> > 
> > Correct, will accommodate this change.
> 
> But note that this patch is just documenting bindings already accepted
> and part of kernel. You probably need another patch which fixes the
> incorrect bindings and this one can then document in fixed bindings.
> 

Correct Sekhar I meant the same. I will have patch for driver to accommodate
above change and a patch for missing binding document.

Thanks,
Prakash

> Thanks,
> Sekhar
> 
