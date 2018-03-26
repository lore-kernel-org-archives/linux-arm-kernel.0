From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Mon, 26 Mar 2018 10:20:05 +0200
Subject: [PATCH v2 4/6] i2c: i2c-stm32: Add generic DMA API
In-Reply-To: <20180324225138.d5yipagxiouoyqtl@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-5-git-send-email-pierre-yves.mordret@st.com>
 <20180324225138.d5yipagxiouoyqtl@ninjato>
Message-ID: <43b6d8d7-37e6-1fe8-6a53-0202ab25cfb1@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the heads-up !
My driver supports DMA, but hardly used in the system.

But it's worth to mentioned it.

On 03/24/2018 11:51 PM, Wolfram Sang wrote:
> On Wed, Mar 21, 2018 at 05:48:58PM +0100, Pierre-Yves MORDRET wrote:
>> This patch adds a generic DMA API to implement DMA support for i2c-stm32fx
>> drivers
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> In case you haven't read it so far, there is a new document about I2C &
> DMA -> Documentation/i2c/DMA-considerations
> 
> Just so you know...
> 
