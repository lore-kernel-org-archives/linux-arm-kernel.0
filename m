From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 6 Sep 2012 11:28:10 +0200
Subject: [PATCH RFC] clk: use spinlock for clk_get_rate
In-Reply-To: <1346919146-25972-1-git-send-email-shawn.guo@linaro.org>
References: <1346919146-25972-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAPDyKFo38_zJBZ2K1gNSre0+C4hF8A2bkg2eyZum=5izkEEELw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Interesting problem you found. :-)

Just a note, that in my suggested patch: "[PATCH 1/4] clk: Provide
option for clk_get_rate to issue hw for new rate",
the prepare mutex will be required to keep.

Not sure if that should be considered as a part of the solution to the
cpufreq problem, but anyway, thought you should know.

KInd regards
Ulf Hansson
