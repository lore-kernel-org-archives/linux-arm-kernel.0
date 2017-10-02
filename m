From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Oct 2017 10:25:24 +0100
Subject: [v3,20/22] hwmon: add support for sensors exported via ARM SCMI
In-Reply-To: <20171001142605.GA340@roeck-us.net>
References: <1506604306-20739-21-git-send-email-sudeep.holla@arm.com>
 <20171001142605.GA340@roeck-us.net>
Message-ID: <7bd07042-895b-a4c2-ec58-f941f07883f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/10/17 15:26, Guenter Roeck wrote:
> On Thu, Sep 28, 2017 at 02:11:44PM +0100, Sudeep Holla wrote:
>> Create a driver to add support for SoC sensors exported by the System
>> Control Processor (SCP) via the System Control and Management Interface
>> (SCMI). The supported sensor types is one of voltage, temperature,
>> current, and power.
>>
>> The sensor labels and values provided by the SCP are exported via the
>> hwmon sysfs interface.
>>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: linux-hwmon at vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Couple of minor comments. With those addressed,
> 

Yes, I have fixed them locally now.

> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks.

-- 
Regards,
Sudeep
