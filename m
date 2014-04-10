From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 18:07:58 +0200
Subject: [PATCH 1/4] pinctrl: msm: Correct interrupt code for TLMM v2
In-Reply-To: <1396302597-31801-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1396302597-31801-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CACRpkdb3DD4r97jJbMV9d9=eZxFU8zSXu1eAGsM=ax+ebFDZ8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 11:49 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> Acking interrupts are done differently between on v2 and v3, so add an extra
> attribute to the pingroup struct to let the platform definitions control this.
> Also make sure to start dual edge detection by detecting the rising edge.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Patch applied for fixes. Sorry for the delay.

Yours,
Linus Walleij
