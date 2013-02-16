From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Feb 2013 15:41:53 -0200
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
 <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
 <20130208161811.GW17833@n2100.arm.linux.org.uk>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
 <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
Message-ID: <CAOMZO5DxcrSRgvjzHUHgHTfqeUL772KrUWk4vgcMrAoje=g-7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Feb 8, 2013 at 3:14 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Feb 8, 2013 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
>
>> From dc381a5dff9663901a61fe0dd86c986add382281 Mon Sep 17 00:00:00 2001
>> From: Will Deacon <will.deacon@arm.com>
>> Date: Fri, 8 Feb 2013 16:41:19 +0000
>> Subject: [PATCH] ARM: tlb: fix branch predictor maintenance for ARMv6
>>
>> The BPIALL operation is not available on all CPUs, so ensure that we
>> only execute it on processors implementing the instruction.
>>
>> Reported-by: Fabio Estevam <festevam@gmail.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> Thanks, Will.
>
> This makes the kernel to boot again on my mx28evk, so:
>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Do you plan to submit this patch to Russell's patch system?

Thanks,

Fabio Estevam
