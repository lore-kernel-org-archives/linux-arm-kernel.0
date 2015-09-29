From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 29 Sep 2015 09:40:56 +0100
Subject: [PATCH] arm-cci500: Don't enable PMU driver by default
In-Reply-To: <20150928233138.GB30986@localhost>
References: <1443452244-14062-1-git-send-email-suzuki.poulose@arm.com>
 <20150928233138.GB30986@localhost>
Message-ID: <560A4E98.8050208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/15 00:31, Olof Johansson wrote:
> On Mon, Sep 28, 2015 at 03:57:24PM +0100, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Disable building CCI-500 PMU driver by default.
>>
>> Reported-by: Russell King <linux@arm.linux.org.uk>
>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: arm at kernel.org
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/bus/Kconfig |    1 -
>>   1 file changed, 1 deletion(-)
>
> Applied as fix for 4.3.

Thanks Olof !

Suzuki
