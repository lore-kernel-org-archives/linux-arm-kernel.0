From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 1 Aug 2013 15:08:06 +0800
Subject: [PATCH 1/2] pinctrl: imx: work around select input quirk
In-Reply-To: <20130801065147.GM8540@nchen-desktop>
References: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
 <20130801065147.GM8540@nchen-desktop>
Message-ID: <CAAQ0ZWQajP49jM_0wqvqmuv19ZcSQ_1QUzgxfsBYzKU_5w0bMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2013 14:51, Peter Chen <peter.chen@freescale.com> wrote:
> Shawn, input_reg[i] may be 0 if the fixed one at first register of IOMUXC

Ah, yes.  Now select input register at offset 0 becomes possible.  I
will try to fix it.

Regardless of this, does the series work for you?

Shawn
