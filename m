From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 08 Sep 2015 13:48:18 +0900
Subject: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <20150908042017.GJ26760@linux>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux> <55EE5C79.2030604@samsung.com>
 <20150908042017.GJ26760@linux>
Message-ID: <55EE6892.3010304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.09.2015 13:20, Viresh Kumar wrote:
> On 08-09-15, 12:56, Krzysztof Kozlowski wrote:
>> There were no comments from your side for this patchset nor for previous
>> Marek's fix. After mentioned change and Bart's re-spin, do you plan to
>> grab this patchset and send it for current v4.3 cycle?
> 
> Why do you think it should go via Kukjin's tree and not Rafael's?

Somehow my mind stuck on solving Exynos4x12 cpufreq issues.

Right, it should go through Rafael's, probably except DTS patch (4/4)
because it depends on previous DTS changes. These changes are still in
arm-soc, not in Linus' tree [0].

Best regards,
Krzysztof

[0]
https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=next/late&id=f44997412e5b39b6a1231f16555120c5b2aae0ed
