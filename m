From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 27 Jun 2016 16:11:54 +0100
Subject: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
In-Reply-To: <5771416E.1040000@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
 <5771392B.3080002@linaro.org> <57714043.5020207@arm.com>
 <577140A7.60904@linaro.org> <57714106.2040200@arm.com>
 <5771416E.1040000@linaro.org>
Message-ID: <5771423A.1030708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/06/16 16:08, Daniel Lezcano wrote:
> On 06/27/2016 05:06 PM, Sudeep Holla wrote:

[...]

>> Ah ok, anyways LPI always starts from index 0. IIUC that was your main
>> concern.
>
> Do you have a repo where I can see the code ?
>

Yes, you can get it from [1]

--
Regards,
Sudeep

[1] http://git.kernel.org/sudeep.holla/linux/h/for_review/arm64_lpi
