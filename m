From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 10 Jul 2015 17:42:17 +0530
Subject: [PATCH 3/3] regulator: 88pm800: Add dev_info to show probe success
 status
In-Reply-To: <13146.1436470614@turing-police.cc.vt.edu>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
 <13146.1436470614@turing-police.cc.vt.edu>
Message-ID: <559FB6A1.7060903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 01:06 AM, Valdis.Kletnieks at vt.edu wrote:
> On Thu, 09 Jul 2015 18:11:32 +0530, Vaibhav Hiremath said:
>> This patch adds dev_info line at the end of probe function, to
>> clearly put status of regulator probe on console. Useful during
>> development, specially to check bootlog.
>
> I can see that as a development thing...
>
>> +	dev_info(&pdev->dev, "Regulator registered ...\n");
>
> In which case this should be 'dev_debug()' or similar so it doesn't
> clutter up and slow down a production boot.
>

Yeup,

Probably dev_debug would have been better here.

Thanks,
Vaibhav
