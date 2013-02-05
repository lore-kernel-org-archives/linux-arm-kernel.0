From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 19:00:09 +0100
Subject: [PATCH 7/9] gpiolib: let gpio_chip reference its descriptors
In-Reply-To: <1359822572-26009-9-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-9-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdZ3L15vbfBGC-SmmGKnt8N_GZGKP92su3aZWQZdPPVR2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Add a pointer to the gpio_chip structure that references the array of
> GPIO descriptors belonging to the chip, and update gpiolib code to use
> this pointer instead of the global gpio_desc[] array. This is another
> step towards the removal of the gpio_desc[] global array.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.orh>

Yours,
Linus Walleij
