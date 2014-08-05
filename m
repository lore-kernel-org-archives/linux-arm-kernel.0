From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue, 05 Aug 2014 15:00:10 +0300
Subject: [PATCH v4 0/3] Support for Qualcomm QPNP PMIC's
In-Reply-To: <53E085C9.4090302@smartplayin.com>
References: <1406903450-27283-1-git-send-email-svarbanov@mm-sol.com>
 <53E085C9.4090302@smartplayin.com>
Message-ID: <53E0C74A.2040108@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pramod,

On 08/05/2014 10:20 AM, Pramod Gurav wrote:
> Hi Stanimir.
> On Friday 01 August 2014 08:00 PM, Stanimir Varbanov wrote:
>> Hello all,
>>
>> Changes since v3:
>>  - rename the driver to qcom-spmi-pmic - suggested by David Collins
>>  - spmi regmap config now initialize .fast_io to true
>>  - added generalized comptatible string in DT binding document and driver
>>  - I dropped the pm8921 rename patch for now, it will be subject of another
>>    patchset later on.
>>
>> regards,
>> Stan
>>
>> --------------------------------------------------------------------------------
>>
>> Changes since v2:
>>  - 1/4 - added new line, signed-off-by / acked-by and module_authors.
>>  - 3/4 - the subject has been changed.
>>
>> The previous v2 can be found at [1].
>>
>> I'm still waiting Acks for:
>>  - 4/4 from Qualcomm folks.
> 
> If I am not missing something obvious, this patch needs to be resent as
> it does not apply on top of patches in this series. I tried applying and
> it fails in Kconfig.

I dropped 4/4 from v4. See above what has been changed since v3.

-- 
regards,
Stan
