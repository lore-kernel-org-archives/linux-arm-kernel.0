From: bill_carson@126.com (bill)
Date: Wed, 20 Apr 2011 16:22:47 +0800 (CST)
Subject: Query about vexpress_ct_ca9x4 watchdog issue ?
In-Reply-To: <4DAE94B6.9060309@st.com>
References: <4DAE94B6.9060309@st.com> <4DAE885F.3060308@st.com>
	<4DAE62EF.7050508@st.com>
	<1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
	<4b3cc9c7.13699.12f71a8b503.Coremail.bill_carson@126.com>
	<fa59500.14272.12f71cec204.Coremail.bill_carson@126.com>
Message-ID: <632b2879.153ae.12f72012291.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



t 2011-04-20 16:09:26?"viresh kumar" <viresh.kumar@st.com> wrote:

>On 04/20/2011 12:57 PM, bill wrote:
>>> Sorry i got confused here. Which driver did you test coh901327_wdt.c or SP805.
>>> >1310 doesn't have 805, neither have coh901327_wdt. It has cortex watchdog, for which
>>> >support is not added for spear.
>>> >
>>> >coh901327_wdt.c is for ST Ericsson's U300 soc.
>>> >
>>> >
>> I miss type the file name, it's cortexa9_wdt.c that I used test on SPEAr1310.
>> this file was rename with sp805_wdt.c in new kernel version.
>> 
>
>No. This is wrong.
>There is no driver in kernel with name cortexa9_wdt.c. I sent patch for it once
>but it never made through, and so we aren't supporting wdt for 1310 in mainline at all.
>
>sp805 was present in spear3xx & 6xx.
>
>What do you want to test sp805 or cortexa9_wdt???

Oh, sorry for that.

I want to test sp805 on mach-vexpress.

thanks
bill

>
>-- 
>viresh
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
