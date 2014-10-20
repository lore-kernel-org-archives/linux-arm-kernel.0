From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 20 Oct 2014 14:35:58 +0200
Subject: [PATCH v9 00/10] rtc: at91sam9: add DT support
In-Reply-To: <20141020141748.063d6835@bbrezillon>
References: <1411483725-31532-1-git-send-email-boris.brezillon@free-electrons.com>
 <20141020141748.063d6835@bbrezillon>
Message-ID: <544501AE.7030706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/2014 14:17, Boris Brezillon :
> Hi Alessandro,
> 
> On Tue, 23 Sep 2014 16:48:35 +0200
> Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
> 
>> Hello,
>>
>> This patch series adds DT support to the atmel at91sam9 RTC driver.
>>
>> It also removes any machine specific inclusions to prepare the migration
>> to multi platform kernel support, and retain the slow clock to prevent
>> the CCF from disabling it at the end of boot.
> 
> Nicolas was planning to take this series (except for patch 10 which was
> already applied by Lee) in his tree for 3.19, but if you prefer to take
> it into yours just let us know.

Absolutely, I'll happily take them for at91-3.19-drivers and push them
through arm-soc tree unless Alessandro says otherwise.

Bye,
-- 
Nicolas Ferre
