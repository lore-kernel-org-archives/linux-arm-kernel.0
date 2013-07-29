From: robherring2@gmail.com (Rob Herring)
Date: Mon, 29 Jul 2013 09:39:36 -0500
Subject: [PATCH 4/7] cpuidle: calxeda: add support to use PSCI calls
In-Reply-To: <51F678DB.3030308@linaro.org>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
 <1375048598-15637-5-git-send-email-robherring2@gmail.com>
 <51F678DB.3030308@linaro.org>
Message-ID: <51F67EA8.8010603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 09:14 AM, Daniel Lezcano wrote:
> On 07/28/2013 11:56 PM, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This updates the Calxeda cpuidle driver to use PSCI calls to powergate
>> cores. This is needed to enable cpuidle for the ECX-2000.
>>
>> This could possibly become a generic PSCI driver, but there are no other
>> PSCI users in the kernel other than mach-virt.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm at vger.kernel.org
>> ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks.

> 
> Rob,
> 
> Shall I take the patch in my tree ?

No, there are interdependencies with the rest of the series, so I plan
to send to arm-soc.

Rob
