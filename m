From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 09 May 2014 22:10:14 +0900
Subject: [PATCH V5 18/20] ARM: exynos: cpuidle: Pass the AFTR callback
 to the platform_data
In-Reply-To: <201405091256.54755.arnd@arndb.de>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
 <1397212815-16068-19-git-send-email-daniel.lezcano@linaro.org>
 <201405091256.54755.arnd@arndb.de>
Message-ID: <536CD3B6.7060108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/14 19:56, Arnd Bergmann wrote:
> On Friday 11 April 2014, Daniel Lezcano wrote:
>> No more dependency on the arch code. The platform_data field is used to set the
>> PM callback as the other cpuidle drivers.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Viresh Kumar<viresh.kumar@linaro.org>
>> Reviewed-by: Bartlomiej Zolnierkiewicz<b.zolnierkie@samsung.com>
>
> This has just shown up in linux-next and broken randconfig builds.
>
Hi Arnd,

Hmm...I just reverted this series in for-next of samsung tree and will 
hold on until solving the randconfig build breakage. I need to look at 
this again and think about your suggestion...

Thanks,
Kukjin
