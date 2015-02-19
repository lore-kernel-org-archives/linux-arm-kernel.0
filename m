From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 19 Feb 2015 14:23:27 +0530
Subject: [PATCH v5 59/61] dmaengine: Add a warning for drivers not using
 the generic slave caps retrieval
In-Reply-To: <20150219090917.159d3d2f@endymion.delvare>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <1416231775-31252-60-git-send-email-maxime.ripard@free-electrons.com>
 <CAOh2x=n1SC+s3hyFaOpREwVuzvqDUwb5vsTBN0As+O2h6eXbMw@mail.gmail.com>
 <20150219090917.159d3d2f@endymion.delvare>
Message-ID: <CAKohpokmmA3wCiao0hBzecRYRvKKyVo3LSO1a=EMLJCP3OmPuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2015 at 13:39, Jean Delvare <jdelvare@suse.de> wrote:
> My understanding is that the warning message is here on purpose to
> instruct DMA driver authors to fix their code. So if anyone need to fix
> anything, that would be you and Andy. That being said, I suspect Andy

To some extent yes, but Andy has already tried to fix that for most of
the drivers and so I just pointed out that something is missed.

> already did that:
>
> commit 029a40e97d0db269f4a7fc02b0f29f627f628309
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Fri Jan 2 16:17:24 2015 +0200
>
>     dmaengine: dw: provide DMA capabilities
>
> Brian, can you please try the latest Linus or linux-next kernel (or
> backport the above commit to your current kernel) and confirm that the
> backtraces are no longer printed?

Maybe yes.
