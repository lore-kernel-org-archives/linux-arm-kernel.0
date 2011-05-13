From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 13 May 2011 14:50:37 +0530
Subject: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
In-Reply-To: <BANLkTik2OxGdQ7z1JBAsE+=gc5UCgx3wEA@mail.gmail.com>
References: <4DCA0B77.8060700@st.com>	<4DCCAB19.2020302@st.com>
	<BANLkTik2OxGdQ7z1JBAsE+=gc5UCgx3wEA@mail.gmail.com>
Message-ID: <4DCCF7E5.2090009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2011 12:24 PM, Linus Walleij wrote:
> 2011/5/13 viresh kumar <viresh.kumar@st.com>:
>> Linus, Jamie,
>>
>> Have you ever seen this kind of issue? Which spi slave memories did you used for testing?
>> I am using standard pl0022 and m25p80 driver. Tried in all modes: polling, interrupt, dma.
> 
> Not really. I'll throw in a few people on CC and see if they have some hints.
> 

Thanks guys.

Issue is solved now, data must be latched on Rising Edge and i have passed phase as falling edge.

--
viresh
