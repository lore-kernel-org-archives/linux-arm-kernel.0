From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Fri, 6 Oct 2017 09:53:23 +0200
Subject: [PATCH v1] i2c:i2c-stm32f7: fix setup structure
In-Reply-To: <20171005111444.77qib2ddnz4jmbnr@ninjato>
References: <1506000609-27409-1-git-send-email-pierre-yves.mordret@st.com>
 <20171005111444.77qib2ddnz4jmbnr@ninjato>
Message-ID: <3b0e9bd4-298f-3ec9-7560-9758a8198e27@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/05/2017 01:14 PM, Wolfram Sang wrote:
> On Thu, Sep 21, 2017 at 03:30:09PM +0200, Pierre-Yves MORDRET wrote:
>> I2C drive setup structure is not properly allocated.
>> Make it static instead of pointer to store driver data.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> Ouch! How did it work before?

Well yes it did. When it has been discovered during internal code review I was
skeptical but it turned out to be true. I tested on STM32 F7/H7 without any
trouble : scary !

> 
> Applied to for-current, thanks! Please provide a Fixes: tag next time,
> did this for you now.
> 
Sorry I wasn't aware about that. I gonna remember for the next time.
Thanks !

Py
