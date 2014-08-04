From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 04 Aug 2014 09:16:59 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140802151352.GL3952@lukather>
References: <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <53DA3A48.8070900@metafoo.de> <20140731161331.GD3952@lukather>
 <53DA74B3.6060502@metafoo.de> <20140731173730.GH3952@lukather>
 <53DB490A.5040709@metafoo.de> <20140801085707.GI3952@lukather>
 <20140801171551.GG8181@intel.com> <53DBD7CD.3030103@metafoo.de>
 <20140802151352.GL3952@lukather>
Message-ID: <53DF336B.6000802@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2014 05:13 PM, Maxime Ripard wrote:
> On Fri, Aug 01, 2014 at 08:09:17PM +0200, Lars-Peter Clausen wrote:
>> On 08/01/2014 07:15 PM, Vinod Koul wrote:
>>> On Fri, Aug 01, 2014 at 10:57:07AM +0200, Maxime Ripard wrote:
>>>> On Fri, Aug 01, 2014 at 10:00:10AM +0200, Lars-Peter Clausen wrote:
>>>>> On 07/31/2014 07:37 PM, Maxime Ripard wrote:
>>>>>> On Thu, Jul 31, 2014 at 06:54:11PM +0200, Lars-Peter Clausen wrote:
>>>>>>> On 07/31/2014 06:13 PM, Maxime Ripard wrote:
>>>>>>> [...]
>>>>>>>>  From what you're saying, and judging from the drivers that already
>>>>>>>> implement it, can't it be moved directly to the framework itself ?
>>>>>>>>
>>>>>>>
>>>>>>> What exactly do you mean by moving it directly to the framework? The
>>>>>>> slave_caps API is part of the DMAengine framework.
>>>>>>
>>>>>> Not its implementation, which is defined by each and every driver,
>>>>>> while the behaviour of device_slave_caps is rather generic.
>>>>>>
>>>>>
>>>>> Do you mean something like adding a dma_slave_caps struct field to
>>>>> the DMA channel that gets initialized when the channel is created
>>>>> and then remove the callback? That makes some sense.
>>>>
>>>> I was rather thinking into something like:
>>>>    - Splitting device_control into independant functions
>>> I like this part :)
>>
>> I started working on this a while ago by splitting out the
>> slave_config functionality into its own callback. Haven't managed to
>> finalize it since it wasn't really top priority.
>
> He, I've done the same yesterday... Do you plan on submitting it soon,
> or should I keep going?

The plan was to submit it eventually. But if you already did it as well, go 
for it.

- Lars
