From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 08:06:02 +0530
Subject: [PATCH 00/10] OPP: Add code to support operating-points-v2
 bindings
In-Reply-To: <CAKohpokaiCq8kq5xALyW-q1QXvUJo2uv2ZbbFYfVFMT0XAqdzA@mail.gmail.com>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <CAKohpokaiCq8kq5xALyW-q1QXvUJo2uv2ZbbFYfVFMT0XAqdzA@mail.gmail.com>
Message-ID: <20150717023602.GD5828@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-06-15, 22:14, Viresh Kumar wrote:
> On 15 June 2015 at 17:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi Guys,
> >
> > This adds code to support operating-points-v2 bindings. Not everything
> > is supported yet, but most of the basic stuff is.
> >
> > Tested with: Exynos 5250, dual cortex A15 board. With both old and new
> > bindings.
> >
> > Bindings are already frozen:
> > http://marc.info/?i=cover.1433434659.git.viresh.kumar%40linaro.org
> >
> > Pushed here as well for reference:
> > ssh://git at git.linaro.org/people/viresh.kumar/linux.git opp/v2
> 
> I am really hoping to get all basic stuff pushed in for 4.3, can we have
> some review of the code please?

@Stephen: Can you please review rest of the stuff?

@Nishanth: Can you please review the series, now that you are back :)

@Rafael: Can you please apply the patches Acked by Stephen for 4.3, so
that I don't have to resend them again ?

-- 
viresh
