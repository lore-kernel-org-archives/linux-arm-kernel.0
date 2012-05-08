From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 May 2012 13:45:23 -0700
Subject: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
In-Reply-To: <4FA98153.4050405@linaro.org> (Daniel Lezcano's message of "Tue,
 08 May 2012 22:25:55 +0200")
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
 <1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
 <4FA98153.4050405@linaro.org>
Message-ID: <87sjfammfw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 05/04/2012 07:18 PM, Daniel Lezcano wrote:
>> Define a CPU_IDLE section in the makefile, declare the functions in
>> the header files conforming to the kernel coding rules and remove the
>> 'define's in the C files.
>>
>> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle drivers
>> use some functions from the pm subsystem.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>> ---
>
> Hi Kevin,
>
> you did not apply this patch. Is it something wrong with it ?
>

oops, the reply was still in my drafts folder... just sent.

Kevin
