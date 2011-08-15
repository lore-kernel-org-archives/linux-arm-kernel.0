From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 15 Aug 2011 08:49:20 +0100
Subject: [PATCH kernel-3.0] arm:cache-l2x0: Fix L2 Cache size calculation.
In-Reply-To: <20110814204851.GA1948@e102144-lin.cambridge.arm.com>
References: <1313142327-18320-1-git-send-email-srinivas.kandagatla@st.com>
	<20110812102020.GD14904@e102144-lin.cambridge.arm.com>
	<20110813084129.GM4775@n2100.arm.linux.org.uk>
	<20110814204851.GA1948@e102144-lin.cambridge.arm.com>
Message-ID: <4E48CF80.6070105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending the patch with Acked by and CC lines in patch...

Thanks,
--srini

Will Deacon wrote:
> Hi Russell,
>
> On Sat, Aug 13, 2011 at 09:41:29AM +0100, Russell King - ARM Linux wrote:
>   
>> On Fri, Aug 12, 2011 at 11:20:20AM +0100, Will Deacon wrote:
>>     
>>> On Fri, Aug 12, 2011 at 10:45:27AM +0100, Srinivas KANDAGATLA wrote:
>>>       
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>>>
>>>> This patch fixes L2 Cache size calculations for L2C-210, L2C-310 and
>>>> PL310, by changing the L2X0_AUX_CTRL_WAY_SIZE_MASK from 2 bits to 3
>>>> bits.
>>>>         
>
> [...]
>
>   
>>> Please can you CC stable on this too?
>>>       
>> It's probably better to ask people to add a Cc: line to the _attributations_
>> rather than telling them to CC the stable tree with their email, and then
>> get a whinge from the stable maintainers about how that's not how to submit
>> patches for stable trees.
>>     
>
> Of course, that's what I intended but unfortunately my choice of words
> was ambiguous.
>
> Srinivas: can you add the CC stable line to your patch please and put it
> into Russell's patch system?
>
> Thanks,
>
> Will
>   
