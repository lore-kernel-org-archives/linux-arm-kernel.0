From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 4 Aug 2011 09:09:39 +0530
Subject: spi/spi-pl022: Query on working of DMA mode
In-Reply-To: <CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
References: <4E3931B7.3010400@st.com>
	<CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
Message-ID: <4E3A147B.9060305@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2011 08:28 PM, Linus Walleij wrote:
>> > Here, allocation is requested with GFP_KERNEL flag, from a tasklet.
>> > Which gives following crash logs:
> What happens if you replace it with GFP_NOWAIT?
> 
> That should work for everybody.
> 
> Or you could remove the tasklet allover and replace it with a workqueue.
> 

Ok. I will fix this and include in my patchset.

>> > Is DMA mode working in your case?
> Yes, magically :-/

But how? Don't you have any message with more than one transfer in it?

-- 
viresh
