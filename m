From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 27 Nov 2018 15:34:03 +0100
Subject: [PATCH v2] i2c: i2c-stm32f7: add PM Runtime support
In-Reply-To: <20181127121034.GK1107@kunai>
References: <1542625464-4704-1-git-send-email-pierre-yves.mordret@st.com>
 <20181127121034.GK1107@kunai>
Message-ID: <bcaa7139-de5c-c578-10d3-4b01d53628b3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Sorry for the inconvenience.
I re-submit a v3 right now.

Thanks

On 11/27/18 1:10 PM, Wolfram Sang wrote:
> On Mon, Nov 19, 2018 at 12:04:24PM +0100, Pierre-Yves MORDRET wrote:
>> Use PM Runtime API to enable/disable clock
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> Looks good but doesn't apply on top of your other patches for me. Can
> you rebase?
> 
