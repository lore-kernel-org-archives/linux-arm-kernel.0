From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 16 Apr 2012 19:14:34 +0530
Subject: Pinctrl crash on latest linux-next/master
In-Reply-To: <CACRpkdb9JOKK=XY0t3GcrOCxyfefi5nw08S4yv=bXREemOM10w@mail.gmail.com>
References: <4F8BFA3F.5030409@st.com>
 <CACRpkdb9JOKK=XY0t3GcrOCxyfefi5nw08S4yv=bXREemOM10w@mail.gmail.com>
Message-ID: <CAOh2x=nFB-s0U4HO=f9-iXCeNj75zJGu0G24AuMkwkhPkCiwEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/12, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Apr 16, 2012 at 12:53 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
>
>> I don't know if the issue is in my patches or something else, but i was
>> able to boot it earlier. Till my V3 for pinctrl. And nothing much changed
>> since then, i just rebased on latest kernel.
>
> Hm I haven't tested the pinctrl tree on v3.4-rc3 yet.
>
> Did you git bisect to figure out which patch broke it?

No.
Don't have a lot of SPEAr patches upstream till now. And have to apply all
of them, on all bisections. So skipped it :)

--
viresh
