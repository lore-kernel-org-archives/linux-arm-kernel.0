From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 26 Feb 2016 19:08:01 +0100
Subject: [PATCH v3 1/4] net: ethernet: dwmac: add Ethernet glue logic for
 stm32 chip
In-Reply-To: <1456483912-32090-2-git-send-email-alexandre.torgue@gmail.com>
References: <1456483912-32090-1-git-send-email-alexandre.torgue@gmail.com>
 <1456483912-32090-2-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <CAGhQ9Vy7VNjtCpqqUpnuMVfArryO7ixpGeUcvziUr6wBee8fog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

When people comment on your patch please CC them on the next version.

On 26 February 2016 at 11:51, Alexandre TORGUE
<alexandre.torgue@gmail.com> wrote:
> stm324xx family chips support Synopsys MAC 3.510 IP.
> This patch adds settings for logical glue logic:
> -clocks
> -mode selection MII or RMII.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>

Driver looks good now, thanks.

Reviewed-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
