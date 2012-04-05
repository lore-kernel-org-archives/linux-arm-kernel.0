From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 12:37:24 +0530
Subject: [PATCH] clk: Update comment for clk_round_rate()
In-Reply-To: <20120405070324.GB27274@pengutronix.de>
References: <CAOh2x=nTSvOrJa2uB2zTvYh1SUO2YpEpnLcL189itJ=_e+MPog@mail.gmail.com>
 <CAJOA=zOPn0FcwO0McSb8-18h7LiJndRD2nmCCvxUEEm+fakvKg@mail.gmail.com>
 <4F7D299E.1050307@st.com> <20120405070324.GB27274@pengutronix.de>
Message-ID: <4F7D44AC.6040605@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2012 12:33 PM, Uwe Kleine-K?nig wrote:
> It depends on your scenario. E.g. for an UART clock it might be better
> to choose 130. Here choosing the frequency is not about a fixed maximum
> but to match the sample rate of the device connect to your UART.

My point was: we can almost always guarantee that device will still
be operational at any frequency below the one requested. But it may
not work at any freq above the requested one. So, giving 130 here may
break it.

-- 
viresh
