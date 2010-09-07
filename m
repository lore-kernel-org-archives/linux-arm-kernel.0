From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 15:43:22 +0530
Subject: [PATCH 15/74] ST SPEAr: adding support for rtc
In-Reply-To: <20100906210943.0e8eb7df@linux.lan.towertech.it>
References: <cover.1283161023.git.viresh.kumar@st.com>	<d9930e7793964f07a2e0acf7f52b45306e308ddd.1283161023.git.viresh.kumar@st.com>
	<20100906210943.0e8eb7df@linux.lan.towertech.it>
Message-ID: <4C861042.1030409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 12:39 AM, Alessandro Zummo wrote:
> On Mon, 30 Aug 2010 16:11:00 +0530
> Viresh KUMAR <viresh.kumar@st.com> wrote:
> 
>> > From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>  Hi, there are quite a few issues. Please read the
>  checklist at http://groups.google.com/group/rtc-linux/web/checklist

Alessandro,

I tried to find issues in driver, with help of checklist. I could find
very few changes initially, they are:
- Correct MODULE_* at end of file
- add platform dependency in Kconfig
- remove .owner
- removed few #includes.

If there are any more issues that you might have encountered, then
please let me know before i send V2.

thanks
viresh.
