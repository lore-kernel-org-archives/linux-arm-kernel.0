From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 11:44:13 +0200
Subject: [PATCH v6 2/2] arm64: dts: move from ARCH_VULCAN to ARCH_THUNDER2
In-Reply-To: <1489495634-2920-3-git-send-email-jnair@caviumnetworks.com>
References: <1489313015-4783-1-git-send-email-jnair@caviumnetworks.com>
 <1489495634-2920-1-git-send-email-jnair@caviumnetworks.com>
 <1489495634-2920-3-git-send-email-jnair@caviumnetworks.com>
Message-ID: <CAK8P3a1db5vs9MtbN2ZcKFF2=9AH+omVaGi0ndBcSEW2t0H7Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 1:47 PM, Jayachandran C
<jnair@caviumnetworks.com> wrote:
> Move and update device tree files as part of transition from Broadcom
> Vulcan to Cavium ThunderX2.
>
> The changes are to:
>  * rename dts/broadcom/vulcan.dtsi to cavium/thunder2-99xx.dtsi,
>    update cpu cores to be "cavium,thunder2", and update SoC to be
>    "cavium,thunderx2-cn9900"
>  * move SoC dts/broadcom/vulcan-eval.dtsi to cavium/thunder2-99xx.dtsi
>    and update board name string
>  * Update dts/broadcom/Makefile not to build vulcan dtbs
>  * Update dts/cavium/Makefile to build thunder2 dtbs
>
> No changes to the dts contents except the updated "compatible" and
> "model" properties.
>
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Applied to next/dt64.

The contents are fine, but I'd recommend using 'git format-patch -M'
when creating a submission for easier review, in case you do another
patch with a rename in the future.

       Arnd
