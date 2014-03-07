From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 7 Mar 2014 08:05:35 -0800
Subject: [PATCH 0/7] pinctrl-msm cleanups
In-Reply-To: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
References: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAJAp7OhjkdW92PKk8xwkHSLx260Y_--ed5cePrk6cMe=k3RAXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 6, 2014 at 10:44 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Here are some small fixes and cleanups for the msm pinctrl
> driver.
>
> Stephen Boyd (7):
>   pinctrl: msm: Silence recursive lockdep warning
>   pinctrl: msm: Check for ngpios > MAX_NR_GPIO
>   pinctrl: msm: Drop unused includes
>   pinctrl: msm: Drop OF_IRQ dependency
>   pinctrl: msm: Replace lookup tables with math
>   pinctrl: msm: Remove impossible WARN_ON()s
>   pinctrl: msm: Simplify msm_config_reg() and callers
>
>  drivers/pinctrl/Kconfig           |  2 +-
>  drivers/pinctrl/pinctrl-msm.c     | 73 ++++++++++++++-------------------------
>  drivers/pinctrl/pinctrl-msm.h     |  5 +--
>  drivers/pinctrl/pinctrl-msm8x74.c |  1 -
>  4 files changed, 27 insertions(+), 54 deletions(-)

Looks good

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
