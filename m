From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 4 May 2012 15:08:37 -0700
Subject: [PATCH V4] clk: add a fixed factor clock
In-Reply-To: <CAOh2x=mF5MjG_TM0S7W+r8=eVXf3v9SBsaxADZYFTjtPKoRm4w@mail.gmail.com>
References: <85453b2bb4d448d0dcd291579bd76e70c1b48e5b.1336039424.git.viresh.kumar@st.com>
 <20120503120821.GJ4141@pengutronix.de>
 <CAOh2x=mF5MjG_TM0S7W+r8=eVXf3v9SBsaxADZYFTjtPKoRm4w@mail.gmail.com>
Message-ID: <CAJOA=zMQNMj2wup2sjXOce41DWmY=jdCC=Z-T9nHFjuGBG0yog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2012 at 6:41 AM, viresh kumar <viresh.linux@gmail.com> wrote:
>
> On May 3, 2012 5:38 PM, "Sascha Hauer" <s.hauer@pengutronix.de> wrote:
>>
>
>> > + ? ? if (clk)
>> > + ? ? ? ? ? ? return clk;
>>
>> ? ? ? ?if (!IS_ERR(clk))
>
> Oops. @Mike: can you please fix it while applying?

No problem.

Regards,
Mike
