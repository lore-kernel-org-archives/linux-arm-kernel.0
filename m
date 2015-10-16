From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 16 Oct 2015 13:31:12 +0200
Subject: [PATCH] ARM: at91: pm: at91_pm_suspend_in_sram() must be 8-byte
 aligned
In-Reply-To: <20151016112252.GA17165@gradator.net>
References: <1444991945-7946-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20151016112252.GA17165@gradator.net>
Message-ID: <5620E000.7050704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 16/10/2015 13:22, Sylvain Rochet a ?crit :
> Hi,
> 
> On Fri, Oct 16, 2015 at 12:39:05PM +0200, Alexandre Belloni wrote:
>> From: Patrick Doyle <pdoyle@irobot.com>
>>
>> fncpy() requires that the source and the destination are both 8-byte
>> aligned.
>>
>> Signed-off-by: Patrick Doyle <pdoyle@irobot.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Additional tags:
> 
> Fixes: d94e688cae56 ("ARM: at91/pm: move the copying the sram function to the sram initialization phase")
> Cc: <stable@vger.kernel.org> # 4.1+

Absolutely: thanks Sylvain.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thank you to Patrick for having found this issue.

Best regards,
-- 
Nicolas Ferre
