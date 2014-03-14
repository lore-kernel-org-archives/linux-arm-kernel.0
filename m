From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 14 Mar 2014 09:46:49 +0000
Subject: [PATCH v4 4/6] pinctrl: st: Use ARRAY_SIZE instead of raw value
 for number of delays
In-Reply-To: <5322CF87.5000301@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>	<1394614210-15698-5-git-send-email-maxime.coquelin@st.com>	<1394634313.28839.57.camel@joe-AO722>
 <CACRpkda0Z15zC=d8xe+KyHqgmTCHbnUjL14fBmtscpR-2kHtFQ@mail.gmail.com>
 <5322CF87.5000301@st.com>
Message-ID: <5322D009.3090000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/14 09:44, Maxime Coquelin wrote:
>>>
>>> drivers/pinctrl/pinctrl-st.c-   unsigned int    *input_delays;
>>> drivers/pinctrl/pinctrl-st.c-   unsigned int    *output_delays;
>>>
>>> It may be better to change these to const unsigned int *
>>> and change
>>>
>>> static unsigned int stih416_delays[] = {
>>>
>>> to static const
>>
>> Good point. Patches accepted :-)
> 
> Sorry Joe, I forgot to reply.
> 
> I added this to my todo list.
> I will provide the change before end of next week.
> 
Thanks Maxime for taking care of this...

--srini
> Thanks,
> Maxime
