From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 12 May 2015 15:37:41 -0500
Subject: [PATCH 2/3] input: keyboad: imx: add snvs power key driver
In-Reply-To: <20150512184328.GC20725@dtor-ws>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
 <1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
 <20150512184328.GC20725@dtor-ws>
Message-ID: <CAHrpEqQpyO=Fzu206xPUwQE+cvk7rpTd0r0A_bL-V1UWgT7+XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +             ret = devm_request_irq(&pdev->dev, pdata->irq,
>> +                                     imx_snvs_pwrkey_interrupt,
>> +                                     IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, pdev->name, pdev);
>
> Why IRQF_NO_SUSPEND? Also should we not get trigger type from OF data?
>
wake up by PWRON key in freeze mode

Do you have any example to get trigger type from OF data?

best regards
Frank Li
