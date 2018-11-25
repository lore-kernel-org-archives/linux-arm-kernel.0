From: olof@lixom.net (Olof Johansson)
Date: Sun, 25 Nov 2018 14:25:04 -0800
Subject: [PATCH 02/13] ARM: multi_v7_defconfig: Add missing systemd options
In-Reply-To: <20181125211907.9895-2-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-2-otavio@ossystems.com.br>
Message-ID: <CAOesGMjR--5XC1pNMkPHR9BaPfgGfdC8JHAM3oqS3Xte3TQbGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 1:19 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> From: Fabio Berton <fabio.berton@ossystems.com.br>
>
> Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Hi Otavio,

Thanks for these patches. I don't have a reason to _not_ enable
systemd features, but would you mind providing a brief description of
what's not working without this change? Is it completely broken, or is
it just the random-UID featues that don't work, or something else?.
Useful for others to know what's expected to break if someone turns
them off, etc.

Also, I noticed you posted a series of 13 patches, which includes some
dts files for rv1108, some network driver changes and some of these
more generic defconfig changes. I would suggest that you split up your
patches into independent series where possible, especially when they
end up going to different subsystems. Providing suitable cover letters
for the series when you post them is also useful to help reviewers by
summarizing the series, including changes from last time it was
posted, etc. Please address it to the superset of patch receivers on
the series.

I'm asking for the cover letter because this time I was wondering if
there was a reason for the mix of patches so I went looking for it.
Maybe there is a need to group them together even though the
sub-series seem somewhat independent -- I can't tell from the way they
were posted.


Thanks!

-Olof
