From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 16 Mar 2012 09:17:16 +0530
Subject: [PATCH] watchdog/coh901327: convert to use watchdog core
In-Reply-To: <20120315212705.GH10698@spo001.leaseweb.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
 <20120307164240.GA1130@pengutronix.de>
 <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
 <20120315212705.GH10698@spo001.leaseweb.com>
Message-ID: <4F62B7C4.7020702@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2012 2:57 AM, Wim Van Sebroeck wrote:
> Hi Linus,
> 
>> On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>>
>>>>       case WDIOC_GETTIMELEFT:
>>>>               clk_enable(clk);
>>>>               /* Read repeatedly until the value is stable! */
>>>
>>> I was wondering if it pays to put this IOCTL to watchdog_dev and add another
>>> callback to watchdog_ops? I'd think so. Wim, Linus, what do you think?
>>
>> OK with me, shall I hack a patch?
> 
> I think Viresh did something allready.

You can find it here:

http://www.spinics.net/lists/arm-kernel/msg164285.html

-- 
viresh
