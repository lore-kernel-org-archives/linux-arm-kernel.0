From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Fri, 2 Feb 2018 05:24:00 +0000
Subject: [PATCH 2/2] dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage
 example
In-Reply-To: <CAL_JsqLBUDNEWkcrNcrOmuYcR=Gbf2ALD=z4s9AP4poOcBxNRQ@mail.gmail.com>
References: <1517333637-17331-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1517333637-17331-3-git-send-email-yogeshnarayan.gaur@nxp.com>
 <CAL_JsqLBUDNEWkcrNcrOmuYcR=Gbf2ALD=z4s9AP4poOcBxNRQ@mail.gmail.com>
Message-ID: <DB6PR0402MB28383FBE4912EC7E73908B7199F90@DB6PR0402MB2838.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> owner at vger.kernel.org] On Behalf Of Rob Herring
> Sent: Wednesday, January 31, 2018 12:24 AM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd at lists.infradead.org; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Shawn Guo <shawnguo@kernel.org>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>; Boris BREZILLON <boris.brezillon@free-
> electrons.com>; Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Brian Norris
> <computersforpeace@gmail.com>; Han Xu <han.xu@nxp.com>; Fabio Estevam
> <festevam@gmail.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; Suresh Gupta <suresh.gupta@nxp.com>
> Subject: Re: [PATCH 2/2] dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage
> example
> 
> On Tue, Jan 30, 2018 at 11:33 AM, Yogesh Gaur
> <yogeshnarayan.gaur@nxp.com> wrote:
> > Added usage example by adding support for spi-rx-bus-width and
> > spi-tx-bus-width binding.
> 
> Why not just add to existing example? Is there something unclear about adding
> these properties to warrant an example? We don't need every possible option
> enumerated.
> 
Ok, would drop this patch and send another patch having usage of properties spi-rx-bus-width and spi-tx-bus-width in existing example under binding file 'spi-bus.txt'.

Thanks

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C72a7e99bdd
> 6d4d3b645d08d56812d0b2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C636529352384519879&sdata=nux9xbgzSjz7bFAFXOFEzt%2BzEnUPVh5f6A
> mkXK1Pwyk%3D&reserved=0
