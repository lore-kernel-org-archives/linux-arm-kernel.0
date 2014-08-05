From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 05 Aug 2014 11:36:05 +0800
Subject: [PATCH v2 18/18] Documentation: ACPI for ARM64
In-Reply-To: <53DFF18B.5080509@infradead.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-19-git-send-email-hanjun.guo@linaro.org>
 <53DFF18B.5080509@infradead.org>
Message-ID: <53E05125.1030007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-5 4:48, Randy Dunlap wrote:
> On 08/04/14 08:28, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  Documentation/arm64/arm-acpi.txt |  215 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 215 insertions(+)
>>  create mode 100644 Documentation/arm64/arm-acpi.txt
>>
>> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
>> new file mode 100644
>> index 0000000..a6e14a2
>> --- /dev/null
>> +++ b/Documentation/arm64/arm-acpi.txt
>> @@ -0,0 +1,215 @@
>> +ACPI on ARMv8 Servers
>> +---------------------
>> +
> 
> ...
> 
>> +
>> +ACPI Detection
>> +--------------
>> +
>> +Drivers should determine their probe() type by checking for ACPI_HANDLE,
>> +or .of_node, or other information in the device structure. This is
>> +detailed further in the "Driver Recommendations" section.
>> +
>> +In non-driver code If the presence of ACPI needs to be detected at runtime,
>> +then check the value of acpi_disabled. If CONFIG_ACPI not being set,
> 
>                                           If CONFIG_ACPI is not set,

Good catch, We will update it.

Thanks
Hanjun
