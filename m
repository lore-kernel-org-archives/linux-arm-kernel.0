From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 22 Aug 2011 10:28:21 +0200
Subject: [GIT PULL] mmc: atmel rework for next
In-Reply-To: <m24o1dnxjg.fsf@bob.laptop.org>
References: <4E4A8E73.7050705@atmel.com> <m24o1dnxjg.fsf@bob.laptop.org>
Message-ID: <4E521325.9090606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/08/2011 19:03, Chris Ball :
> Hi,
> 
> On Tue, Aug 16 2011, Nicolas Ferre wrote:
>> Hi Chris,
>>
>> Please pull from:
>>
>> git://github.com/at91linux/linux-2.6-at91.git nfe/mmc_atmel
>>
>> This is a series that reworks the atmel-mci driver for a future merge of both at91_mci and atmel-mci drivers. Those patches have been discussed on the mailing-list.
>> I added a tiny at91_mci patch also sent last week.
> 
> Thanks, all looks good -- pushed to mmc-next with some commit message
> rewording.  Please wrap your commit messages to 75 cols in future, so
> that they're viewable in "git log" without wrapping.

Thanks Chris for this. I will pay attention to line wrapping.

> I'll repeat your warning text from one of the commit messages here for
> the broader audience:
> 
>     Warning: at91rm9200 is not supported, to support it we need to use
>     swab32 on data but I have no board to test it.

Best regards,
-- 
Nicolas Ferre
