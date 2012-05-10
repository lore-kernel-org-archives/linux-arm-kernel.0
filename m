From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 10 May 2012 07:27:31 -0700
Subject: [GIT PULL] SPEAr clk updates for v-3.5
In-Reply-To: <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
References: <1336562022-24368-1-git-send-email-viresh.kumar@st.com>
 <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
Message-ID: <CAJOA=zNUeZqgb1Bw48YC3xNGJSquCX_p1HT0H-KJ0D534uUfUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 12:14 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi Viresh,
>
> On Wed, May 9, 2012 at 4:13 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
>> Hi Arnd,Olof,
>>
>> This is rebased over a (merge of Mike's/clk-next & SPEAr's DT) + Russell's
>> patch: CLKDEV: provide helpers for common clock framework rebased over them.
>
> Russell has published a clkdev branch that you pull instead of
> applying his patch manually, that way there will be no surprises with
> respect to conflicts, etc:
>
> git://ftp.arm.linux.org.uk/~rmk/linux-next.git clkdev
>
> It is also in arm-soc as depends/rmk/clkdev now.
>
> Also, Mike, can you please confirm that your clk-next branch is truly
> stable and will never be rebased before it goes upstream? If it might
> be rebased, can you please provide a separate branch that is
> guaranteed to be stable that we can pull in as the dependency here?

clk-next is stable.  It will not be rebased.

Regards,
Mike

>
>
> Thanks,
>
> -Olof
