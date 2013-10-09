From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 9 Oct 2013 14:09:01 -0700
Subject: [GIT PULL] omap fixes against v3.12-rc3
In-Reply-To: <20131009205127.GF8313@atomide.com>
References: <20131008220324.GV8313@atomide.com> <87d2netbvh.fsf@linaro.org>
 <20131009205127.GF8313@atomide.com>
Message-ID: <CAGa+x85i5OXA2cNEAT+hZC-c01xq8ZwTbb4kse=Vw9pS6_i1Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 1:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@linaro.org> [131009 13:50]:
>>
>> FWIW, my automated boot is doing only DT boots on all the OMAP
>> platforms.  However, it's only testing basic boot so far so there's not
>> a whole lot of driver testing yet (but it's coming soon.)
>
> OK cool. For omap3, off-idle with DT needs the pending
> pinctrl-single patches, and some yet unknown way of mapping
> wake-up events to device interrupts. But after that you
> can also do some PM related tests potentially :)

Yeah, a review/test of that series is already my TODO list.

Kevin
