From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 12 Nov 2018 15:38:17 +0200
Subject: [RFC 0/9] ASoC/ARM: Merge the davinci and omap audio directories
In-Reply-To: <1065fb8a-a8ec-fbe3-83eb-a308072ef6d6@bitmer.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
 <1065fb8a-a8ec-fbe3-83eb-a308072ef6d6@bitmer.com>
Message-ID: <812b333e-cd01-ba32-8daa-7783072cb613@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-11-11 18:37, Jarkko Nikula wrote:
> On 11/8/18 10:37 AM, Peter Ujfalusi wrote:
>> The series also includes patches to updated the arch/arm/ files (defconfigs,
>> source files using audio Kconfig symbols).
>>
>> I believe with v1 all of this can be merged via ASoC tree as the chances of
>> conflicts are low for the touched arch/arm files. But Sekhar and Tony can
>> correct me if I'm wrong.
>>
>> I think I have catched all (I hope) issues regarding to Kconfig thanks to the
>> various autobuild machines out there kindly testing my linux-next-wip branch.
>>
>> I would appreciate any testing comments before I send the v1!
>>
> I applied on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git commit
> abd97b7c53ac ("Merge branch 'asoc-4.21' into asoc-next").
> 
> Patches 2 and 6 didn't apply and 7-8 I skipped. For my functional
> testing none of those were required.

Hrm, the series was based on next-20181019, but I will keep on eye on these!

> For the sound/soc/{omap => ti} conversion you may add:
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Thank you!

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
