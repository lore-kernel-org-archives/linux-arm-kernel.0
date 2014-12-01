From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Dec 2014 18:09:03 +0000
Subject: [PATCH] ARM: imx6: fix bogus use of irq_get_irq_data
In-Reply-To: <547CAC27.2090200@arm.com>
References: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
 <547CAC27.2090200@arm.com>
Message-ID: <547CAEBF.7080402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/14 17:57, Vladimir Murzin wrote:
> Hi Marc,
> 
> On 01/12/14 17:04, Marc Zyngier wrote:
>> The imx6 PM code seems to be quite creative in its use of irq_data,
>> using something something that is very much a hardware interrupt
>         ^^^^^^^^^ ^^^^^^^^^
> More "something" here! ;)

Better for me to write "something" a few times too many, rather than
what I actually had in mind when I fixed that code...

	M.
-- 
Jazz is not dead. It just smells funny...
