From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 1 Mar 2011 14:43:07 +0530
Subject: [RFC] device.h: add device_set_platdata routine
In-Reply-To: <20110301090518.GV22310@pengutronix.de>
References: <5c561db378360ad1763da41f8350c7be816daa06.1298953633.git.viresh.kumar@st.com>
	<20110301075953.GR22310@pengutronix.de> <4D6CADE5.6000206@st.com>
	<20110301090518.GV22310@pengutronix.de>
Message-ID: <4D6CB8A3.9080203@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2011 02:35 PM, Uwe Kleine-K?nig wrote:
>> > Ok. So we should use platform_device_add_data instead and mark our platform
>> > data's struct as __init. So that it doesn't consume any memory after
>> > this routine is done??
> Yeah, either __initdata or still better const + __initconst if possible.

Ok. Thanks for your help.

-- 
viresh
