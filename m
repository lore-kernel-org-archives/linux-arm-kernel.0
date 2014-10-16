From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Oct 2014 20:43:27 -0700
Subject: [PATCH 3/4] ARM: dts: add RK3288 suspend support
In-Reply-To: <1413406144-16329-1-git-send-email-zyw@rock-chips.com>
References: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
 <1413406144-16329-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=W-A6Kb77et+eGrkHGizW2_2VcaGH8qQRG-7YOEKcZQ1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Wed, Oct 15, 2014 at 1:49 PM,  <zyw@rock-chips.com> wrote:
> From: Chris Zhong <zyw@rock-chips.com>
>
> add pmu_intmem subnode for suspend, add suspend pinctrl

Maybe mention that it's expected that board files will reference the
suspend pinctrl as part of the PMIC config?
