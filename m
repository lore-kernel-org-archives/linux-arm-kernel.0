From: robherring2@gmail.com (Rob Herring)
Date: Fri, 27 Sep 2013 07:29:27 -0500
Subject: [PATCH] ARM: highbank: cpuidle: convert to platform driver
In-Reply-To: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> As the ux500 and the kirkwood driver, make the calxeda driver a platform driver
>
> [Compiled only]
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-highbank/highbank.c |    8 ++++++++
>  drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)

Looks fine to me, but this will conflict with my series. Perhaps I can
pick this up as part of that.

Rob
