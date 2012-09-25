From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 25 Sep 2012 11:48:43 +0200
Subject: [PATCH] USB: ohci-at91: fix null pointer in
 ohci_hcd_at91_overcurrent_irq
In-Reply-To: <20120924173407.GE32691@kroah.com>
References: <1348433760-2818-1-git-send-email-joachim.eastwood@jotron.com>
 <50600F5F.7030307@atmel.com> <20120924173407.GE32691@kroah.com>
Message-ID: <50617DFB.3070405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2012 07:34 PM, Greg KH :
> On Mon, Sep 24, 2012 at 09:44:31AM +0200, Nicolas Ferre wrote:
>>> This patches fixed the issue by adding the gpio valid check.
>>>
>>> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Thanks a *lot* Joachim for having chased this bug!
>>
>> Alan, Greg, this one is 3.6 last minute material... I Hope that it can
>> make it!
>>
>>> ---
>>>
>>> Note: If 6fffb77c goes into stable please either include this patch also or
>>> fold it into 6fffb77c to avoid regressions.
>>
>> Absolutely, I have tagged the faulty patch:
>>     Cc: Stable <stable@vger.kernel.org> [3.4+]
>>
>> So it can be good if this one can follow the same path.
> 
> I'll queue this up for 3.7 and have it backported to 3.6.1 as it's a bit
> late for 3.6 for me right now.

Ah, too bad! The kernel Oops may affect several AT91 SoC... Can't we
push it with the help of Andrew Morton for late material?

Cheers,
-- 
Nicolas Ferre
