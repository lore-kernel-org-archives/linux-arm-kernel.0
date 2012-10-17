From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 17 Oct 2012 18:52:37 -0500
Subject: [PATCH v3 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
In-Reply-To: <20121016172258.GT15569@atomide.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
 <20121016172258.GT15569@atomide.com>
Message-ID: <CALLhW=5Fmjhd+w57Dmm2BLmBoHuC7_jprJndkw1dHoVzVu4TOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2012 12:22, Tony Lindgren <tony@atomide.com> wrote:
> * Omar Ramirez Luna <omar.luna@linaro.org> [121011 18:07]:
>> These patches are needed for remoteproc to work on OMAP4.
>>
>> Introduced iommu hwmod support for OMAP3 (iva, isp) and
>> OMAP4 (ipu, dsp), along with the corresponding runtime PM
>> and routines to deassert reset lines, enable/disable clocks
>> and configure sysc registers.
>>
>> Although IOMMU hwmod patches were already submitted in the past,
>> this series adds few more changes, like:
>> - New reset handling.
>> - Save and restore context code rework.
>> - Device tree bindings for OMAP3 and OMAP4.
>>
>> For this series I just dropped the patches already included in
>> mainline.
>
> These will need to be rebased on omap-for-v3.8/cleanup-headers-iommu
> when I have that pushed out as that removes plat/*iommu*.h files.

Ok, will wait and rebase on top of it.

Thanks,

Omar
