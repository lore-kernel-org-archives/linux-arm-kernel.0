From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 03 Sep 2014 23:11:23 +0900
Subject: [PATCHv6 0/2] thermal: exynos: Add support for TRIMINFO feature of
 Exynos3250
In-Reply-To: <20140830023928.GC23645@developer>
References: <1409713743-6124-1-git-send-email-cw00.choi@samsung.com>
 <20140830023928.GC23645@developer>
Message-ID: <5407218B.1020702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Eduardo,

On 08/30/2014 11:39 AM, Eduardo Valentin wrote:
> Hi,
> 
> On Wed, Sep 03, 2014 at 12:09:01PM +0900, Chanwoo Choi wrote:
>> This patchset add the support of TRIMINFO_RELOAD feature for Exynos3250.
>> But Exynos3250 has two TRIMINFO_CTRL register instead other Exynos has only one
>> TRIMINFO_CTRL register. So, this patchset support the some Exynos SoC which
>> has more than one TRIMINF_CTRL.
>>
>> Also, this patchset fix wrong value of TRIMINFO_RELOAD_SHIFT and remove
>> duplicate code when reading triminfo register of Exynos5440.
>>
>> Changes from v5:
>> - Rebase this patchset on next branch of linux-soc-thermal.git
>>
> 
> Pulled into my next branch. Thanks.

Thanks.

Best Regards,
Chanwoo Choi
