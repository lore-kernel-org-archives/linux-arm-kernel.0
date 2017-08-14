From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Aug 2017 15:57:56 +0200
Subject: [PATCH 4/8] gpio: zynq: Provided workaround for GPIO
In-Reply-To: <4f1f7ed79879d17e38ffda095d631d0f561c2818.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <4f1f7ed79879d17e38ffda095d631d0f561c2818.1502103715.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdaM7TN8pg=E6ETJrZYfN8AC-CNY8CWJrWUrsX=EP+gnRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 1:01 PM, Michal Simek <michal.simek@xilinx.com> wrote:

> From: Swapna Manupati <swapna.manupati@xilinx.com>
>
> This patch provides workaround in the gpio driver
> for Zynq and ZynqMP Platforms by reading pin value
> of EMIO banks through DATA register as it was unable
> to read the value of it from DATA_RO register.
>
> Signed-off-by: Swapna Manupati <swapnam@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Patch applied.

(I hope my random application of patches does not screw things
up, then I guess I need to back some out.)

Yours,
Linus Walleij
