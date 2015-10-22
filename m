From: fainelli@broadcom.com (Florian Fainelli)
Date: Thu, 22 Oct 2015 14:57:49 -0700
Subject: [PATCH] clk: iproc: Make clocks visible options
In-Reply-To: <20151022201433.GK651@broadcom.com>
References: <1445541913-25066-1-git-send-email-jonmason@broadcom.com>
 <56293D26.7080006@broadcom.com> <20151022201433.GK651@broadcom.com>
Message-ID: <56295BDD.4000609@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/10/15 13:14, Jon Mason wrote:
> On Thu, Oct 22, 2015 at 12:46:46PM -0700, Scott Branden wrote:
>> Hi Jon,
>>
>> comments inline.
>>
>> On 15-10-22 12:25 PM, Jon Mason wrote:
>>> Make the clocks visible options that can be selected by anyone.  This
>>> avoids the problems of:
>>>  1) Select is a reverse dependency and is hard for people to understand
>>>     and can sometimes be a pain to track down
>> This doesn't make any sense to me - there are many selects in the
>> system and this is one of them.
> 
> This was specifically requested by Stephen Boyd, and the above are
> his words verbatum
> https://lkml.org/lkml/2015/10/21/956

I am soon going to introduce a new clock driver under drivers/clk/bcm/
which is going to need some Kconfig tweaks as well, it would be good if
we reached consensus on this so Stephen can apply this.

Thanks!
-- 
Florian
