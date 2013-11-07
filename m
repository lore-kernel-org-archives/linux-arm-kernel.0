From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 7 Nov 2013 09:42:04 +0800
Subject: [PATCH] irqchip: bcm2835: Convert to use IRQCHIP_DECLARE macro
In-Reply-To: <524B8657.5060803@wwwdotorg.org>
References: <1372955496.9018.2.camel@phoenix> <51E23995.4040606@wwwdotorg.org>
 <524B8657.5060803@wwwdotorg.org>
Message-ID: <CAFRkauAon5ehuE=mCkZSSSq6fK9nKh6ZmdUuAwgsK8OEQ18ZsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/10/2 Stephen Warren <swarren@wwwdotorg.org>:
> On 07/13/2013 11:39 PM, Stephen Warren wrote:
>> On 07/04/2013 10:31 AM, Axel Lin wrote:
>>> This patch converts irq-bcm2835 driver to use the new IRQCHIP_DECLARE and
>>> irqchip_init.
>>
>> I guess the diffs to the ARM tree are much smaller than the irqchip
>> tree, so it's simplest to take it through the irqchip tree, so,
>>
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
>
> I don't see this patch in linux-next yet. Thomas, do you want to take it
> through the irqchip tree, or should I take it through the bcm2835 tree?
>
Hi,
Seems this patch is still not in linux-next yet.
Just wondering if it will be applied for 3.13?

Regards,
Axel
