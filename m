From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 17 May 2012 09:56:10 +0530
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
Message-ID: <4FB47DE2.4070704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/13/2012 5:24 AM, Linus Walleij wrote:
>>> >> Viresh Kumar (6):
>>> >>       gpiolib: Add of_get_gpio_chip_by_phandle() helper
>> >
>> > I thought the first patch "gpiolib: Add of_get_gpio_chip_by_phandle() helper"
>> > was not actually accepted. What was the outcome of that discussion?
> None. I am ambivalent and a bit lost so I prefer if Grant advice on this one...

Hi Linus/Arnd,

Tomorrow is my last day in ST, so just trying to get this fixed before that. :)
As Grant hasn't replied till now, what about updating this routine to 

of_get_gpio_chip_base_by_phandle()

that will return base of gpio chip instead of its pointer. This would solve the
concerns shared by Linus earlier.

Will this change be good enough to get this patchset pushed?

-- 
viresh
