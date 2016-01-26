From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 26 Jan 2016 20:31:28 -0300
Subject: [PATCH v6 0/5] dma-mapping: Patches for speeding up allocation
In-Reply-To: <1452533428-12762-1-git-send-email-dianders@chromium.org>
References: <1452533428-12762-1-git-send-email-dianders@chromium.org>
Message-ID: <CABxcv==WXG4zq8mr+KE4zKNkgG9y8etUQM7ZQiB2rPeKz1ySLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On Mon, Jan 11, 2016 at 2:30 PM, Douglas Anderson <dianders@chromium.org> wrote:

[snip]

>
> All testing was done on the chromeos kernel-3.8 and kernel-3.14.
> Sanity (compile / boot) testing was done on a v4.4-rc6-based kernel on
> rk3288, though the video codec isn't there.  I don't have graphics / MFC
> working well on exynos, so the MFC change was only compile-tested
> upstream.  Hopefully someone upstream whose setup for MFC can give a
> Tested-by for these?
>

I tested these patches on a Exynos5800 Peach Pi Chromebook. The
s5p-mfc driver probes correctly and the allocation succeeds.

I also tried to test actual video decoding using Gstreamer but ran
into issues (not related to this series) so testing that won't be
trivial for me.

It shouldn't block Doug's series though IMHO since he tested on his
platform and the patches speeds up allocation there, so is an
improvement.

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
