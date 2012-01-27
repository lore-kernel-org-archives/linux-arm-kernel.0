From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Fri, 27 Jan 2012 10:58:08 +0100
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <20120126161744.GB19703@opensource.wolfsonmicro.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1FD1A5.1060305@samsung.com>
 <20120125112602.GB2991@opensource.wolfsonmicro.com>
 <4F1FEF55.8030604@samsung.com>
 <20120125133254.GJ3687@opensource.wolfsonmicro.com>
 <4F217100.6020105@samsung.com>
 <20120126161744.GB19703@opensource.wolfsonmicro.com>
Message-ID: <4F227530.3050708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On 25.01.2012 12:22, Mark Brown wrote:
>>> The big problem there seems like specifying voltages in the first
>>> place, if we know what device it is we should already know what's
>>> going on.
>
>> Driver which handles said regulator might know what's going on, but
>> that might not be case for its consumers.  Should we limit ability to
>> query given parameter just because its value is hardcoded in hardware?
>
> I'm sorry, this makes no sense.  Setting a value in the constraints is
> not going to have any impact on the value reported by the driver, it
> never has.

... with the exception of fixed regulator, that is. This is from where I 
got my flawed understanding.

Looking at other drivers I see that's indeed special case not practiced 
elsewhere.

Thanks for explaining this.

Regards,
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
