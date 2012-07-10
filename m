From: cjb@laptop.org (Chris Ball)
Date: Mon, 09 Jul 2012 23:22:28 -0400
Subject: [PATCH] mmc: atmel-mci: modify CLKDIV displaying in debugfs
In-Reply-To: <4FFA82D1.5080904@atmel.com> (ludovic desroches's message of
 "Mon, 9 Jul 2012 09:05:53 +0200")
References: <1341569511-11340-1-git-send-email-nicolas.ferre@atmel.com>
 <4FFA82D1.5080904@atmel.com>
Message-ID: <87liisti4r.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 09 2012, ludovic.desroches wrote:
> Le 07/06/2012 12:11 PM, Nicolas Ferre a ?crit :
>> Modify clock division displaying in debugfs for matching
>> the new CLKDIV,CLKODD user interface arrangement.
>> Is using the has_odd_clk_div property to choose the proper format.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
