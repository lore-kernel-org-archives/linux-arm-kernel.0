From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 14 Mar 2018 11:16:32 +0100
Subject: [PATCH] ARM: dts: sun8i-h3: Add Mali node
In-Reply-To: <20180314080500.whywwskhp5546z7m@flea>
References: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180314080500.whywwskhp5546z7m@flea>
Message-ID: <1269750b-5190-a167-8d34-91794e6d0a8c@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 14/03/2018 09:05, Maxime Ripard ha scritto:
> On Tue, Mar 13, 2018 at 11:16:45AM +0100, Giulio Benetti wrote:
>> The H3 has an ARM Mali 400 GPU, so add binding to our DT.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> How was this tested?

I wanted you asked me about this to ask you:
if I can't test it on HW, but others tested it all around,
for example using this patch:
https://github.com/armbian/build/blob/master/patch/kernel/sunxi-next/32-h3-DT-add-mali-node.patch

Is it enough? Or do I have to test it directly?
Or maybe I can invite those people to tag this patch as tested-by ?

> 
> Is there any specific reason not to share it with the H5?

Yes, H5 has dual GPU but quad PP and on IRQ you can clearly see:
- GPU_GP
- GPU_GPMMU
- GPU_PMU
- GPU_PP
- GPU_PP0
- GPU_PPMMU0
- GPU_PP1
- GPU_PPMMU1
- GPU_PP2
- GPU_PPMMU2
- GPU_PP3
- GPU_PPMMU3

So I think they should be placed in specific dts files.
What do you think?

Thanks

> 
> Maxime
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
