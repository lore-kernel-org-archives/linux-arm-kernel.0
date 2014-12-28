From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Dec 2014 20:24:23 +0900
Subject: [PATCH 1/2] pinctrl: exynos: Add AUDIO pin controller for exynos7
In-Reply-To: <1418994659-5222-2-git-send-email-padma.v@samsung.com>
References: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
 <1418994659-5222-2-git-send-email-padma.v@samsung.com>
Message-ID: <549FE867.5000306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.12.2014 22:10, Padmavathi Venna wrote:
> Audio IPs on Exynos7 require gpios available in AUDIO
> pin controller block. So adding the AUDIO pinctrl support.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>   .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
>   drivers/pinctrl/samsung/pinctrl-exynos.c           |   10 ++++++++++
>   2 files changed, 11 insertions(+), 0 deletions(-)

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
