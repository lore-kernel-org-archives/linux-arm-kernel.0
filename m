From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 6 Apr 2016 10:14:36 +0200
Subject: [v7, 0/5] Fix eSDHC host version register bug
In-Reply-To: <HE1PR04MB0889D75DC56E180D3508E7A1F89F0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFqgMCvbqMYZ-uM-rTnVvfJkCYbhv2kucCRyNyc9FWoR=Q@mail.gmail.com>
 <HE1PR04MB0889D75DC56E180D3508E7A1F89F0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Message-ID: <CAPDyKFp8GDzSkpbTKoRL=rwiBrsWmsgN95zB-QJwfZTnq4M8BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> I was about to queue this for next, when I noticed that checkpatch is
>> complaining/warning lots about these patches. Can you please a round of
>> checkpatch and fix what makes sense.
>>
>> Kind regards
>> Uffe
>
> [Lu Yangbo-B47093] Sorry about this, Uffe...

No worries!

> Should I ignore the warnings that update MAINTAINERS?

drivers/soc/fsl/guts.c isn't part of the MAINTAINERS file, it should be.

I also realize that the FREESCALE QUICC ENGINE LIBRARY section
drivers/soc/fsl/qe/* also need an active maintainer, as it's currently
orphan.

Perhaps we should have create a new section for drivers/soc/fsl/*
instead that covers all of the above? Maybe you or Scott are
interested to pick it up?

I also noted that, "include/linux/fsl/" isn't present in MAINTAINERS,
please add that as well.

> Regarding the 'undocumented' warning, I will added a patch updates doc before all the patches, Ok?

Yes, good!

>
> Thanks a lot :)
>

Kind regards
Uffe
