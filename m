From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 13 Jun 2012 10:06:12 +0100
Subject: [PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates
 & fixes
In-Reply-To: <4F8E4C4C.5030702@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
 <4F83FEE0.8020709@st.com> <4F8E4C4C.5030702@st.com>
Message-ID: <CAOh2x=kFZ8KemoqyczBqObwk=+qx0XL_FMQ-qwJvWK++631K_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

On Wed, Apr 18, 2012 at 6:08 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 4/10/2012 3:05 PM, Viresh KUMAR wrote:
>> On 3/12/2012 9:51 AM, Viresh KUMAR wrote:
>>> Hello,
>>>
>>> This patchset contains fixes and updates for ARM watchdog drivers sp805 and
>>> mpcore.
>>>
>>> Changes since V1:
>>> - Included patches for sp805 driver.
>>> - Removed: wdt->clk = NULL from mpcore driver, and use IS_ERR() to check if
>>> ? clock is supported or not.
>>> - Adapted to watchdog core for both the drivers.
>>> - two patches for watchdog core added
>>> - add patch to use __raw_readl{writel} instead of readl{writel}
>>> - taken care of few more review comments.
>>>
>>
>> Hi Wim,
>>
>> Have you applied patches left in this patchset for linux-next?
>
> Ping!!

You planned to push them in v-3.5. Isn't it?
