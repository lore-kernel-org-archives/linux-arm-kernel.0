From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 16 Mar 2018 10:19:41 +0100
Subject: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
In-Reply-To: <20180316064731.muiw5yumhmfnwxg2@flea>
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180316064731.muiw5yumhmfnwxg2@flea>
Message-ID: <658946b9-4f49-ff24-3b84-da1eb9b7d9ad@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Il 16/03/2018 07:47, Maxime Ripard ha scritto:
> Hi Giulio,
> 
> On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>> for the needed pins.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Like we discussed last time, we only merge this kind of patches if
> there's an immediate user.

You're right.
In few time(I hope), I'm going to send dts for Linova1-4_3 and Linova1-7,
where I use those pins.
I have also to send 2 patches for 2 new panels for panel-simple.

So I think I have to send 2 displays' patches before.
And a patchset for the 2 boards and rgb888 pins.

One question: do I have to wait for panels' patches to applied and then 
send patchset for boards dts?
Or can I send a unique patchset?
Because as I understand those patches should be applied to 2 different 
repositories, right?

Thanks in advance

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

> 
> Maxime
> 
