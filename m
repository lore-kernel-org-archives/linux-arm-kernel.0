From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 3 Jul 2016 21:08:40 +0200
Subject: ARM: mediatek: dts 32 bits updates for v4.8
In-Reply-To: <94a90d0c-f459-296c-4290-739515b4ac5b@gmail.com>
References: <94a90d0c-f459-296c-4290-739515b4ac5b@gmail.com>
Message-ID: <98233d90-47ef-88f7-e474-c1fa04a65c04@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/03/2016 08:49 AM, Matthias Brugger wrote:
> Hi all,
>
> Please take into account the following dts patch for arm 32 bits.
>

The patch causes a compilation error, please don't pull this branch.

Sorry for the noise,
Matthias

> Thanks,
> Matthias
>
> ---
>
> The following changes since commit
> 1a695a905c18548062509178b98bc91e67510864:
>
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>
> are available in the git repository at:
>
>   https://github.com/mbgg/linux-mediatek.git tags/v4.7-next-dts32
>
> for you to fetch changes up to 6f108172f13c311ce2175fab25fbd50940a3622b:
>
>   ARM: dts: mt2701: add iommu/smi dtsi node for mt2701 (2016-07-03
> 08:25:08 +0200)
>
> ----------------------------------------------------------------
> - Add dtsi parts for iommu support
>
> ----------------------------------------------------------------
> Honghui Zhang (1):
>       ARM: dts: mt2701: add iommu/smi dtsi node for mt2701
>
>  arch/arm/boot/dts/mt2701.dtsi | 50
> +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
