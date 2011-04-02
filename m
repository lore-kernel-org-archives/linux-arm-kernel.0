From: davem@davemloft.net (David Miller)
Date: Sat, 02 Apr 2011 01:35:41 -0700 (PDT)
Subject: [PATCH 1/1] net/fec: do not pass NULL dev to DMA API
In-Reply-To: <AANLkTi=FMsH7Px2m9WkRVyHfGZ9MLvgp-XPHu3Amsu7+@mail.gmail.com>
References: <20110402.005714.258110130.davem@davemloft.net>
	<20110402083131.GB26533@S2100-06.ap.freescale.net>
	<AANLkTi=FMsH7Px2m9WkRVyHfGZ9MLvgp-XPHu3Amsu7+@mail.gmail.com>
Message-ID: <20110402.013541.02274640.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Liu <liu.h.jason@gmail.com>
Date: Sat, 2 Apr 2011 16:35:19 +0800

> 2011/4/2 Shawn Guo <shawn.guo@freescale.com>:
>> Hi David,
>>
>> On Sat, Apr 02, 2011 at 12:57:14AM -0700, David Miller wrote:
>>>
>>> First, your patches never make it to the mailing list because the list
>>> server rejects your postings, due to the fact that there are syntax
>>> errors in your email headers:
>>>
>>> Illegal-Object: ? ? ? Syntax error in From: address found on vger.kernel.org:
>>> ? ? ? From: ? Aisheng.Dong<b29396@freescale.com>
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ^-missing end of mailbox
>>>
>> Yes, we were aware of that the mail did not get distributed by vger
>> list. ?But we do not know why. ?Thanks for telling.
>>
>> I'm not quite sure about the "^" indication. ?Is it telling that there
>> should be a space between display name and mail address?
> 
> We should not use A.B <>, instead should use A B <>.

Yes, this is also true.

Characters such as "." must not appear in email headers in this
context unless protected by double quotes.
