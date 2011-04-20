From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 20 Apr 2011 13:57:56 +0530
Subject: Query about vexpress_ct_ca9x4 watchdog issue ?
In-Reply-To: <632b2879.153ae.12f72012291.Coremail.bill_carson@126.com>
References: <4DAE94B6.9060309@st.com> <4DAE885F.3060308@st.com>
	<4DAE62EF.7050508@st.com>
	<1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
	<4b3cc9c7.13699.12f71a8b503.Coremail.bill_carson@126.com>
	<fa59500.14272.12f71cec204.Coremail.bill_carson@126.com>
	<632b2879.153ae.12f72012291.Coremail.bill_carson@126.com>
Message-ID: <4DAE990C.50302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2011 01:52 PM, bill wrote:
>> >What do you want to test sp805 or cortexa9_wdt???
> Oh, sorry for that.
> 
> I want to test sp805 on mach-vexpress.
> 

Ok. So, this is what i said earlier.
sp805 driver is working fine on spear3xx & 6xx.
It looks that you are also not getting WDT reset after specified timeout? Is it so?

The only thing i can think of now is clock.
Can you simply program wdt using some debugger instead of driver and see if reset is
happening??

--
viresh
