From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Sep 2015 16:19:45 +0900
Subject: [PATCH v5 0/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <20150914071727.GB32551@linux>
References: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
 <2547413.Uj7KDUeGpY@vostro.rjw.lan> <55F6728A.2070805@samsung.com>
 <20150914071727.GB32551@linux>
Message-ID: <55F67511.5000908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2015 16:17, Viresh Kumar wrote:
> On 14-09-15, 16:08, Krzysztof Kozlowski wrote:
>> If you want, the fourth patch can go now through your tree - the late
>> SoC changes were pulled by Linus. No difference... I can grab it as I
>> had other DT related fix in queue.
>>
>> The only important thing is to get entire patchset to 4.3 because it is
>> a fix for regression introduced in cpufreq for exynos. Do you plan to
>> send your part in current 4.3 cycle?
> 
> The first 3 patches are already part for 4.3-rc1 and so you can keep
> the DT update in your tree now. :)

Damn it, I missed it. It solves everything, the fourth patch will go
through platform tree.

Best regards,
Krzysztof
