From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue, 7 Mar 2017 19:38:32 +0000
Subject: [PATCH v2 0/6] Updates for Marvell Switch SoCs
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
 <87bmtdovwr.fsf@free-electrons.com>
Message-ID: <b2dc1865150d46a4b64c0522480bdec6@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 08/03/17 06:10, Gregory CLEMENT wrote:
> Hi Chris,
>
>  On jeu., f?vr. 16 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>
>> Shortly after I posted my last series I got access to a more recent
>> Marvell SDK which had some device tree support for the switch SoCs I'd
>> been wanting. It was still based on an older kernel but it was a huge
>> improvement over what came before.
>>
>> Patch 1/6 is a typo I noticed after my initial series was applied.
>>
>> Patch 2/6 is a bit of a cleanup. I did initially struggle with how to
>> access individual parts of the DFX block as well as retaining a handle on
>> the entire thing for the switch driver to use.
>>
>> Patch 3/6 is a re-jig of the dtsi files which is needed by 5/6. This is
>> required because I need to use the coreclk label on a different node. It
>> also means I don't have to disable nodes for blocks that only exist on
>> the Armada-XP.
>>
>> Patch 4/6, 5/6 are split from the previous versions.
>>
>> Patch 6/6 is the device tree portion of a change already in clk-next.
>
>
> I applied patches 2, 3 and 6 on mvebu/dt with the acked-by from Rob when
> he gave it.
>
> Patch 1 is already part of 4.11-rc1.
>
> For patch 4 and 5 I understand that either we don't need it or it should
> be a updated version so I skipped them.
>

That's correct, thanks.
