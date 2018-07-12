From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Jul 2018 09:01:57 -0700
Subject: NVIDIA Tegra changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-1-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
Message-ID: <CAOesGMiJ9Mt6nCfZ5SrkKQHPcb1tO4O+xNmKwgWdeF1AQn8FTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 12, 2018 at 8:41 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Hi ARM SoC maintainers,
>
> Here's the set of Tegra-related pull requests for v4.19-rc1. I'm sending
> these a week earlier than usual because I will be on vacation for the
> next two weeks. During my absence, Jon Hunter will be taking the helm.
> Unfortunately he doesn't have access to the kernel.org repository, so if
> anything comes up he may have to send patches to you directly. That said
> I don't expect any issues with these pull requests. They've all soaked
> in linux-next for a little while and I've done my regular sanity builds
> and didn't see any issues.

Sounds good. Jon, we're OK with merging from a github repo or similar
as well, if you have more than a few patches. Please re-send them to
arm at kernel.org with your sign-off when you have something (it's a lot
easier than if you just cc us on an acked-by, since gmail+imap doesn't
pop the whole thread over into my arm@ folder. :)

We can even host a rebasing/staging/temporary branch for you in case
you want something to be in -next but might not be 100% that it should
go in, if needed -- just let us know.

> In the unlikely case that everything falls apart, I'll be back shortly
> after v4.18-rc7, which should give us a little time to clean things up
> before the merge window.

Yeah, hopefully not much. And thanks a lot for communicating your
vacation schedules, it's useful for us to know!


-Olof
