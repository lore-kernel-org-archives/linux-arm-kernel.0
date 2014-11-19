From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 17:54:55 +0100
Subject: [PATCH v7 0/3] new Atmel DMA controller
In-Reply-To: <20141119110718.GC2074@intel.com>
References: <1413991340-11617-1-git-send-email-ludovic.desroches@atmel.com>
 <20141106052748.GR1870@intel.com> <546C7903.8090901@atmel.com>
 <20141119110718.GC2074@intel.com>
Message-ID: <546CCB5F.8040507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2014 12:07, Vinod Koul :
> On Wed, Nov 19, 2014 at 12:03:31PM +0100, Nicolas Ferre wrote:
>> On 06/11/2014 06:27, Vinod Koul :
>>> On Wed, Oct 22, 2014 at 05:22:17PM +0200, Ludovic Desroches wrote:
>>>> Hi,
>>>>
>>>> This set of patches introduces support for the new Atmel DMA controller know as
>>>> XDMAC and available on SAMA5D4.
>>>
>>> Applied all, thanks
>>
>> Vinod,
>>
>> I saw that you had created a topic branch for this driver: topic/at_xdmac.
>>
>> If this branch is stable, can I use it for my work on at91 support and
>> merge it in my at91-3.19-dt branch before sending it to the arm-soc tree?
>> In fact I need the binding definitions that are created by the
>> patch:(dmaengine: at_xdmac: creation of the atmel eXtended DMA
>> Controller driver).
> Yup please pull this, this wont be rebased

Thanks for your blazing fast answer Vinod. My pull-request is sent now.

Bye,
-- 
Nicolas Ferre
