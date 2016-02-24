From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 24 Feb 2016 16:06:02 +0100
Subject: [PATCH 40/50] pinctrl: lpc18xx: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-41-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-41-git-send-email-ldewangan@nvidia.com>
Message-ID: <CAGhQ9Vzoosj=SpSn-fj1thL9bdfW+cay_truUR9VF8nP9HUwbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laxman,

On 24 February 2016 at 14:16, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Use devm_pinctrl_register() for pin control registration.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-lpc18xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
