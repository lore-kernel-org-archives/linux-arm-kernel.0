From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Jun 2013 05:45:49 +0900
Subject: [PATCH 08/15] pwm: Add new pwm-samsung driver
In-Reply-To: <1395589.x1LsEiFKi9@flatron>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
 <1395589.x1LsEiFKi9@flatron>
Message-ID: <51BE23FD.8030403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/13 02:19, Tomasz Figa wrote:
> Hi Kukjin,
>
> On Wednesday 05 of June 2013 23:18:13 Tomasz Figa wrote:
>> This patch introduces new Samsung PWM driver, which uses Samsung
>> PWM/timer master driver to control shared parts of the hardware.
>>
>> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
>> ---
>>   drivers/pwm/Makefile      |   1 +
>>   drivers/pwm/pwm-samsung.c | 528
>> ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 529
>> insertions(+)
>>   create mode 100644 drivers/pwm/pwm-samsung.c
>
> I you haven't yet merged this patch, please let me send v2 of this series,
> addressing Heiko's comments and adjustments to my understanding of the PWM
> hardware after getting access to SMDK6410 board, which uses PWM to control
> LCD backlight.
>
Sure, let me hold on until getting your updated series.

Thanks,
- Kukjin
