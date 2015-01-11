From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Jan 2015 22:40:18 +0100
Subject: [PATCH v4 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
In-Reply-To: <1420818231-13451-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-8-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdbDEcStJhabgKEm8H=z2umEr+bd-0oK4_HvCO+rz0pTXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 4:43 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Instead of the driver caring about implementation details like device
> tree, just provide information about driver specific pinconf parameters
> to pinconf-generic which takes care of parsing the DT.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied: qualcomm folks, can you make sure that the Qualcomm
stuff is still working as expected with S?ren's core parser?

Yours,
Linus Walleij
