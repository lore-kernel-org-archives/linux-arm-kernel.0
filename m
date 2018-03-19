From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Mon, 19 Mar 2018 09:41:20 +0100
Subject: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
In-Reply-To: <20180317205109.gocf5wemtjkyomct@ninjato>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
Message-ID: <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I do believe the hw can support it, even it looks odd to me having the same I2C
in slave and master mode at the same time.
Nevertheless the driver is devised to support either master or slave more but
not at the same time.

Regards
On 03/17/2018 09:51 PM, Wolfram Sang wrote:
> 
>> + * @master_mode: boolean to know in which mode the I2C is running (master or
>> + * slave)
> 
> It can't do both at the same time?
> 
