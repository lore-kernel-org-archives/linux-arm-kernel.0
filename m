From: viresh.linux@gmail.com (viresh kumar)
Date: Tue, 19 Jun 2012 15:11:08 +0100
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
 <4FB47DE2.4070704@st.com>
 <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
Message-ID: <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2012 at 9:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, May 17, 2012 at 6:26 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
>
>> Tomorrow is my last day in ST, so just trying to get this fixed before that. :)
>> As Grant hasn't replied till now, what about updating this routine to
>>
>> of_get_gpio_chip_base_by_phandle()
>>
>> that will return base of gpio chip instead of its pointer. This would solve the
>> concerns shared by Linus earlier.
>>
>> Will this change be good enough to get this patchset pushed?
>
> I don't know my way around devicetree well enough to answer that...
> anything prefixed of_* is better decided by Grant. I suspect he's
> thinking about it.

@Grant: Can we have your comments here please. Or any other better
solution to the problem
we are facing. I do hope, my last suggestion is not that bad.

--
viresh
