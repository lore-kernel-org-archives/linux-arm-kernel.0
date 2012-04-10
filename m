From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Apr 2012 10:42:50 +0200
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
In-Reply-To: <CAOh2x=n8GO-vzFgDEdeyUVdGiOE_-BxgpC5+LbKRMtvgnoSxHQ@mail.gmail.com>
References: <4F793C56.2030605@st.com>
 <CAOh2x=n8GO-vzFgDEdeyUVdGiOE_-BxgpC5+LbKRMtvgnoSxHQ@mail.gmail.com>
Message-ID: <CACRpkdZgfY340a5=Mgs0WwTO1e4AiKxv3-xm4pbpEg2jOmiNgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 4:59 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> On Apr 2, 2012 11:15 AM, "Viresh Kumar" <viresh.kumar@st.com> wrote:
>>
>> Hi Arnd/Olof,
>>
>> The following changes since commit
>> dd775ae2549217d3ae09363e3edb305d0fa19928:
>>
>> ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
>>
>> are available in the git repository at:
>>
>> ?git://git.stlinux.com/spear/linux-2.6.git spear-dt
>>
>> for you to fetch changes up to 8f21ec99c7b78c3f0baf6bbf2e438da68da3dc08:
>>
>> ?SPEAr: Update defconfigs (2012-04-02 09:03:59 +0530)
>
> Arnd,
>
> I don't exactly know how it works, but Linus
> would require this pull before he applies pinctrl patches.

Will there be conflicts between this patch set and the stuff you're
submitting for pinctrl? Or is it just runtime problems?

The ARM SoC and pinctrl are not on top of each other or anything
like that, they are merged in parallell.

Yours,
Linus Walleij
