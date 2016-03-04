From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 4 Mar 2016 12:10:09 +0100
Subject: [PATCH 02/17] irqchip: Add PLX Technology RPS IRQ Controller
In-Reply-To: <56D871B3.10200@arm.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-3-git-send-email-narmstrong@baylibre.com>
 <000201d17562$5f6f0090$1e4d01b0$@gmail.com> <56D86CA8.6030301@baylibre.com>
 <56D871B3.10200@arm.com>
Message-ID: <56D96D11.1050206@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 06:17 PM, Marc Zyngier wrote:
> On 03/03/16 16:56, Neil Armstrong wrote:
>> On 03/03/2016 04:32 PM, Ma Haijun wrote:
>> Hi Haijun,
>>
>> Thanks for the tips !
>>
>> Indeed the timer looks like the timer-sp804 actually upstream, I'll try this driver before posting a v2.
>>
>> Concerning the IRQ controller, I did not find any similar drivers.
>>
>> Marc, Arnd, should I create a specific "arm RPS irq controller" instead ?
> 
> Why not - I wonder which HW this controller got slapped on... It doesn't
> even have a cryptic name! ;-)
> 
> Thanks,
> 
> 	M.
> 

Actually, it seems we already have an implementation in irq-versatile-fpga, it matches !

Adding a single "arm,rps-irq" compatible string should work.

Neil
