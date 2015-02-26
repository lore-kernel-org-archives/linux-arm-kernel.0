From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Feb 2015 18:52:57 +0100
Subject: [PATCHv3] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <op.xuiwzhcu2s3iss@ecaz>
References: <1424089864-15651-1-git-send-email-kaloz@openwrt.org>
 <54EB7255.7090806@free-electrons.com> <op.xuiwzhcu2s3iss@ecaz>
Message-ID: <54EF5D79.9060503@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Imre,

On 23/02/2015 19:43, Imre Kaloz wrote:
> Hi Gregory,
> 
> On Mon, 23 Feb 2015 19:32:53 +0100, Gregory CLEMENT  
> <gregory.clement@free-electrons.com> wrote:
> 
> ...
> 
>>> @@ -0,0 +1,348 @@
>>> +/*
>>> + * Device Tree file for the Linksys WRT1900AC (Mamba).
>>> + *
>>> + * Note: this board is shipped with a new generation boot loader that
>>> + * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
>>> + * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
>>
>> This symbol name has been removed and DEBUG_MVEBU_UART0_ALTERNATE would
>> be used instead.
>>
>> Besides this,
>>
>> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> You don't have to resend a new version for this, I can amend
>> your patch while applying it. So unless there is new comments
>> I will add your patch to the mvebu tree in a couple of days.
> 
> I knew I will forget something - this has been noted by Andrew back then  
> :) Thank you for taking care of this.


Now applied (amended) on mvebu/dt
Thanks,

Gregory

> 
> 
> Best,
> 
> Imre
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
