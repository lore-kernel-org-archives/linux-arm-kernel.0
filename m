From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 7 Mar 2012 04:10:36 -0800
Subject: [PATCH 12/15] watchdog/mpcore_wdt: Add support for WDIOF_CARDRESET
In-Reply-To: <4F574936.3010909@ru.mvista.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
 <4F574936.3010909@ru.mvista.com>
Message-ID: <CAOh2x==p26zb-vHcX5vnPZYD_P8DWkvTwj=J+4pLytusoMZSOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/12, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> On 07-03-2012 14:27, Viresh Kumar wrote:
>
>> mpcore watchdog can give last boot status, whether we got a watchdog reset
>> or
>> not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to
>> return
>> correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.
>
>     In the subject you say about another ioclt.
>

Actually i mentioned what we add in watchdog_info (WDIOF_CARDRESET) in subject,
and mentioned IOCTL in body. Both are right, but yes they must be
consistent. Will
fix subject in V2.

--
viresh
