From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 14 Sep 2017 17:52:57 +0200
Subject: [PATCH v4 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <20170914154033.gkovgxgjbghtqmre@ninjato>
References: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
 <1505399319-14782-4-git-send-email-pierre-yves.mordret@st.com>
 <20170914154033.gkovgxgjbghtqmre@ninjato>
Message-ID: <f5a75bff-7434-ec32-730f-daa1fbcd61a2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/14/2017 05:40 PM, Wolfram Sang wrote:
> On Thu, Sep 14, 2017 at 04:28:37PM +0200, Pierre-Yves MORDRET wrote:
>> This patch adds initial support for the STM32F7 I2C controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> Thanks for the quick update. I'd think the 'rate_max' variable can now
> be dropped and replaced by 'rate'? If so, we can fix that later
> incrementally.

Many thanks. I will try to put a reminder in my mind for this ;)

> 
> Applied to for-next (will be in 4.14), thanks! The DTS patches need to
> go via arm-soc.
> 

Thanks again !
