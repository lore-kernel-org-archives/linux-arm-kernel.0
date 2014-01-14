From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 14:31:52 -0800
Subject: [GIT PULL 3/4] trivial omap big endian changes for v3.14 merge
 window
In-Reply-To: <20140109012139.GK31323@atomide.com> (Tony Lindgren's message of
 "Wed, 8 Jan 2014 17:21:40 -0800")
References: <20140109011940.GI31323@atomide.com>
 <20140109012139.GK31323@atomide.com>
Message-ID: <871u0a6vqf.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:
>
>   Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/be-signed
>
> for you to fetch changes up to fc6ca98c81bf0ea8b46064915b5947b971594101:
>
>   ARM: OMAP: debug-leds: raw read and write endian fix (2014-01-07 16:09:45 -0800)
>
> ----------------------------------------------------------------
> Trivial search and replace of read and write functions to allow
> further patches to make omaps work also in big endian mode.
>
> ----------------------------------------------------------------

I think this one should wait for v3.15.  While a trivial rename, it's a
pretty broad change and risks having conflicts and fallouts with other
changes (thinking especially of ongoing clock changes.)

Kevin
