From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 11 Jan 2018 15:21:52 +0530
Subject: [PATCH V5 00/13] drivers: Boot Constraint core
In-Reply-To: <CAOesGMgeaWd5z7VEiVhs=Ei3ZWZQN0C-p4smTMCy3AYrZ-TdTA@mail.gmail.com>
References: <cover.1513264961.git.viresh.kumar@linaro.org>
 <CAOesGMgeaWd5z7VEiVhs=Ei3ZWZQN0C-p4smTMCy3AYrZ-TdTA@mail.gmail.com>
Message-ID: <20180111095152.GI3626@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-01-18, 10:54, Olof Johansson wrote:
> The SoC-specific pieces should preferrably go under drivers/soc
> instead, to reduce cross-tree dependencies when introducing new SoC
> variants.
> 
> They're more related to the SoC than to the boot_constraint framework anyway.

Hmm, okay.

> Bikeshed: We've traditionally had really terse and precise names under
> drivers/. This is the first verbose one with a _ in it. Maybe find a
> shorter name or just concatenate to 'bootconstraints'? We didn't call
> it remote_proc or rapid_io, etc, either. :)

Sure.

-- 
viresh
