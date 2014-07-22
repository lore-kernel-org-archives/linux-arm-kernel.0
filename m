From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue, 22 Jul 2014 14:54:00 +0300
Subject: [PATCH v2 4/4] mfd: pm8921: rename pm8921-core driver
In-Reply-To: <20140722103252.GD8406@lee--X1>
References: <1405613855-27572-1-git-send-email-svarbanov@mm-sol.com>
 <1405613855-27572-5-git-send-email-svarbanov@mm-sol.com>
 <20140722103252.GD8406@lee--X1>
Message-ID: <53CE50D8.9070608@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 01:32 PM, Lee Jones wrote:
> On Thu, 17 Jul 2014, Stanimir Varbanov wrote:
> 
>> The pm8921-core driver presently supports pm8921 and pm8058
>> Qualcomm PMICs.  To avoid confusion with new generation PMICs
>> (like pm8941) rename the pm8921-core driver to more
>> appropriate name pm8xxx-ssbi, which reflects better that
>> those chips use SSBI interface.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> ---
>>  drivers/mfd/Kconfig                          |   14 +++++-----
>>  drivers/mfd/Makefile                         |    2 +-
>>  drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} |   38 +++++++++++++-------------
>>  3 files changed, 27 insertions(+), 27 deletions(-)
>>  rename drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} (92%)
> 
> Patch looks fine to me.
> 
>   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> I'm assuming we want to wait for the others in the set to be ready
> before applying?

yes, I think you will need an ack for the DT binding document?

-- 
regards,
Stan
