From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Thu, 11 Mar 2010 15:17:44 +0530
Subject: [PATCH 04/11] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <63386a3d1003102243w637a8ce1m838a2dba946add32@mail.gmail.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>	
	<63386a3d1003092140o67a6c943rdee3a6c905cea7ef@mail.gmail.com>	
	<4B973CF6.4030009@st.com>	
	<63386a3d1003100131v7027e44cu5031c9ee3bf6ec73@mail.gmail.com>	
	<4B977067.3050108@st.com>
	<63386a3d1003102243w637a8ce1m838a2dba946add32@mail.gmail.com>
Message-ID: <4B98BC40.1030306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On 3/11/2010 12:13 PM, Linus Walleij wrote:
> 2010/3/10 Viresh KUMAR <viresh.kumar@st.com>:
> 
>> One timer (or two channels) are used by clock event and clock source, but rest of
>> the timers are still available. So we need some way to export this functionality
>> of our hardware. It can be considered simply as a driver for GPT.
> 
> The timer people have already explained well enough I think, we have some 16
> timers on U8500, one we use as clocksource, one for clock events and 14 are
> currently unused. I plan to add them as clock events as soon as there is some
> practical use for them.
> I think there is nothing stopping you from modelling some extra clock events
> for the remaining timers if you absolutely want to, the kernel will
> just disregard
> them currently, which is just as good/bad as the way you're exposing the custom
> API in these patches.

Can we use clockevents directly? I though they are abstracted by the kernel
framework and using them directly is not advisable/feasible.

regards
Shiraz
