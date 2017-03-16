From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 15 Mar 2017 22:50:58 -0700
Subject: [PATCH] pinctrl: qcom: qdf2xxx: add names to the gpios
In-Reply-To: <1488843122-7960-1-git-send-email-timur@codeaurora.org>
References: <1488843122-7960-1-git-send-email-timur@codeaurora.org>
Message-ID: <CAOCOHw6Epj2ZLB227L_vbZJ02orYb9W5koJcaLxeSJy_gfG+Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 3:32 PM, Timur Tabi <timur@codeaurora.org> wrote:
> The sysfs and debugfs entries for pin control drivers work better when
> the individual pins are given real names, even if they are all just
> "gpio0", "gpio1", etc.
>

Yeah, you do want "name" for those to play nice.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
