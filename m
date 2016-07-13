From: vw@iommu.org (Wan Zongshun)
Date: Wed, 13 Jul 2016 15:26:40 +0800
Subject: [PATCH v2 08/10] ARM: dts: nuc900: Add nuc970 dts files
In-Reply-To: <20160712153910.GA3507@afzalpc>
References: <1468136542-2656-1-git-send-email-vw@iommu.org>
 <20160712153910.GA3507@afzalpc>
Message-ID: <5785ED30.4090206@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?07?12? 23:39, Afzal Mohammed wrote:
> Hi,
>
> On Sun, Jul 10, 2016 at 03:42:20PM +0800, Wan Zongshun wrote:
>> This patch is to add dts support for nuc970 platform.
>
> cpu ! in soc ? lost in fab ? ;)

Do you mean I should add cpus into soc like?


	cpus {
		#address-cells = <0>;
		#size-cells = <0>;

		cpu {
			compatible = "arm,arm926ej-s";
			device_type = "cpu";
		};
	};

>
> Regards
> afzal
>
>
