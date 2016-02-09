From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 9 Feb 2016 13:52:12 -0800
Subject: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
In-Reply-To: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20160209215210.GB27284@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 02:46:27PM +0530, Keerthy wrote:
> OMAP5 has 3 thermal zones cpu, core and multimedia.
> On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> and iva. Currently cpu, core and multimedia are being added via dt
> and the other 2 are getting added via kernel. Add the missing thermal
> domains in dt so as give the correct trip numbers, type and temperatures.
> 
> Tested on DRA7-EVM.

For the series:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

>  
> Keerthy (3):
>   arm: dts: DRA7: Add DSPEVE thermal data
>   arm: dts: DRA7: Add IVA thermal data
>   arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain data
> 
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                |  2 ++
>  3 files changed, 56 insertions(+)
>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
> 
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/7401701f/attachment.sig>
