From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2018 23:26:27 +0200
Subject: [PATCH] perf/arm-cci: Remove VLA usage
In-Reply-To: <20180629184536.GA37337@beast>
References: <20180629184536.GA37337@beast>
Message-ID: <CAK8P3a1+MCxfPdQVXnm2jyQc6tGtV+wpV=_2+tPRBirTvPXTyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 8:45 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the VLA in favor of a maximum size and adds a sanity check
> at registration time. The sizes are all explicitly enumerated already,
> so this just collects them into macros.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Looks good to me,

     Arnd
