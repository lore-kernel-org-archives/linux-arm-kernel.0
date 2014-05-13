From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 15:43:28 +0530
Subject: [PATCH V3 1/3] ARM: EXYNOS5: PMU support for 5420
In-Reply-To: <CAGOxZ52Vnvmu71qH7oJFiuRqbHdtMWYgjjBsPOPf+K52o9tb7Q@mail.gmail.com>
References: <1399546342-30494-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGOxZ52Vnvmu71qH7oJFiuRqbHdtMWYgjjBsPOPf+K52o9tb7Q@mail.gmail.com>
Message-ID: <CAM4voanLYuWDw4pwwEcafy-WJ2vAY9m704cWBU+XF8rgpuCE+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alim,

[...]
>> +       /* Time taken to stabilized XXTI clock */
>> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5_XXTI_DURATION3, 0x005dc);
>> +
> There is no good reason why XXTI_DURATION3 need to be set here. This
> is something that iROM sets, please remove this.
Will remove.

Regards,
Abhilash
