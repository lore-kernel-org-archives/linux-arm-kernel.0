From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 24 Jul 2014 21:43:32 +0200
Subject: [RESEND RFC V2] devicetree: Dialog Semiconductor consolidate
 existing vendor prefixes to standardise on 'dlg'
In-Reply-To: <201407241554.s6OFsqbW031651@swsrvapps-01.diasemi.com>
References: <201407241554.s6OFsqbW031651@swsrvapps-01.diasemi.com>
Message-ID: <1406231012.21800.13.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 24.07.2014, 16:46 +0100 schrieb Opensource [Steve
Twiss]:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> This patch series updates the device tree vendor prefix for
> Dialog Semiconductor.
> 
> Various methods are currently used throughout the kernel: 'diasemi',
> 'dialog' and 'dlg'. Others have also been suggested.
> 
> This patch set aims to consolidate the usage of the vendor prefix to
> use a common standard. The prefix 'dlg' is used.
> 
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> Checks performed with linux-next/next-20140715/scripts/checkpatch.pl
>  trivial-devices.txt       total: 0 errors, 0 warnings, 89 lines checked
>  da9210.txt                total: 0 errors, 0 warnings, 21 lines checked
>  vendor-prefixes.txt       total: 0 errors, 0 warnings, 149 lines checked
>  imx53-smd.dts             total: 0 errors, 2 warnings, 279 lines checked
>  imx6qdl-phytec-pfla02.dtsi total: 0 errors, 2 warnings, 357 lines checked
>  r8a7790-lager.dts         total: 0 errors, 3 warnings, 403 lines checked
>  r8a7791-koelsch.dts       total: 0 errors, 4 warnings, 461 lines checked
>  da9055-core.c             total: 0 errors, 0 warnings, 428 lines checked
> 
> This is a resend according to requests for e-mail reformatting and removal
> of '[]' in From: and Signed-off-by: tags. There are no patch alterations
> from RFC V2.
> 
> I am requesting Acks for the bindings and DTS(I) changes in this patch
> specifically the two remaining files r8a7790-lager.dts and r8a7791-koelsch.dts
> In a previous reply SHMobile was identified as needing to Ack this patch
> before it could proceed.
> - http://www.spinics.net/lists/arm-kernel/msg349289.html
> - https://lkml.org/lkml/2014/6/11/273
> 
> If there are problems with this request, can I get a quick explanation in
> the reply so I can fix it and move forwards please?
> 
> Please see this thread for latest comments:
> http://www.spinics.net/lists/arm-kernel/msg349809.html
> 
> Acked-by the following people so far:
> 
> - Rob Herring
>   http://www.spinics.net/lists/arm-kernel/msg349289.html
> 
> - Lee Jones
>   For the MFD changes:
>   http://www.spinics.net/lists/arm-kernel/msg349457.html
> 
> - Shawn Guo
>   arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
>   arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
