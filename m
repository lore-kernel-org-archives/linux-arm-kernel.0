From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 30 Jan 2017 17:02:44 +0100
Subject: [PATCH 4/7] IIO: add STM32 DFSDM ADC support
In-Reply-To: <14320aef-7956-74bf-e4c3-5f2354cc5493@kernel.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-5-git-send-email-arnaud.pouliquen@st.com>
 <14320aef-7956-74bf-e4c3-5f2354cc5493@kernel.org>
Message-ID: <7d3336e8-ad0b-a52c-5aa8-9b39a503d426@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jonathan,

Thanks for the reviews, i will integrate your comment in next version.

On 01/29/2017 01:15 PM, Jonathan Cameron wrote:
> On 23/01/17 16:32, Arnaud Pouliquen wrote:
>> Add driver to handle Sigma Delta ADC conversion for ADC
>> connected to DFSDM IP.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Various comments inline.  Again mostly reading this to grasp how the whole
> lot fits together.
> 
> At the moment, other than some new ABI, this is a fairly simple sysfs or in
> kernel polled ADC driver.  The hardware seems to support a whole lot more
> but fair enough to present this as a starting point!

Yes, from IIO point of view, should increase driver features in future
to integrate buffer, scan mode, triggers...
Or perhaps i will need to introduce some of these concepts to handle
ASoC requirement in IIO...

FYI, DFSDM also offers some features like Analog watchdog, short circuit
and SPI/manchester bus clock absence detection detection...:)

Regards
Arnaud
