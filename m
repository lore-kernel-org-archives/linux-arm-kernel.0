From: timur@tabi.org (Timur Tabi)
Date: Thu, 21 Mar 2013 11:11:56 -0500
Subject: [PATCH] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <514AC738.6050900@parkeon.com>
References: <20130319170322.27828.7691.stgit@localhost>
 <514A63EE.7000707@tabi.org> <514AC738.6050900@parkeon.com>
Message-ID: <CAOZdJXXv=O3vmSCJ1ojhis+Fn7FJ7yhd2wVt10m77Cixbew2BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 3:39 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> With this patch and that DT example the frequency of clock 162 will be _set_
> to 20MHz

Does that mean that it ignores the ' clocks' parameter?

> If clock-frequency is omitted the binding is still correct (hence the
> optional) but the frequency of clock 162 would not be modified.
>
> In the documentation I wrote "If both a clock and clock-frequency are
> provided the clock's rate will be set. " maybe this is not clear enough?

It's not clear what it will be set *to*.
