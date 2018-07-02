From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Jul 2018 17:50:03 +0100
Subject: [PATCH] perf/arm-cci: Remove VLA usage
In-Reply-To: <20180629184536.GA37337@beast>
References: <20180629184536.GA37337@beast>
Message-ID: <20180702165003.GC23687@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 11:45:36AM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the VLA in favor of a maximum size and adds a sanity check
> at registration time. The sizes are all explicitly enumerated already,
> so this just collects them into macros.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/perf/arm-cci.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Thanks, I'll queue this up for 4.19.

Will
