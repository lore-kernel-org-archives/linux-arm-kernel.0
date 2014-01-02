From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 02 Jan 2014 16:22:37 +0100
Subject: [PATCH 3/3] clk: exynos5250: register APLL rate table
In-Reply-To: <CAK9yfHxRmiUmWjxZx2Uoy37uuYjw03Z2Y=SxaB17Uc-3j1CH_A@mail.gmail.com>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHwTgKW55-ChHNToLGZZ-frd4OJF5Zi5Djt5NzxhOZvcrg@mail.gmail.com>
 <CAK9yfHxRmiUmWjxZx2Uoy37uuYjw03Z2Y=SxaB17Uc-3j1CH_A@mail.gmail.com>
Message-ID: <1418540.7aJQgHWZYx@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 of December 2013 08:46:14 Sachin Kamat wrote:
> On 19 December 2013 09:14, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > Hi Tomasz,
> >
> > On 10 November 2013 22:44, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> >> Hi Sachin, Andrew,
> >>
> >> On Friday 08 of November 2013 15:44:08 Sachin Kamat wrote:
> >>> From: Andrew Bresticker <abrestic@chromium.org>
> >>>
> >>> Register the APLL rate table so that we can set the APLL rate from
> >>> the cpufreq driver.
> >>>
> >>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >>> ---
> >>>  drivers/clk/samsung/clk-exynos5250.c |   25 ++++++++++++++++++++++++-
> >>>  1 file changed, 24 insertions(+), 1 deletion(-)
> >>
> >> You know that you still need to fix the cpufreq driver to use these,
> >> don't you? Anyway:
> >>
> >> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> >
> > This one too needs to be applied to your tree.
> 
> Ping Tomasz.

Applied.

Best regards,
Tomasz
