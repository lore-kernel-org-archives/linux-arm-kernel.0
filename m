From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:25:58 +0200
Subject: [PATCH 4/9] mfd: db8500-prcmu: Supply the pdata_size attribute
 for db8500-thermal
In-Reply-To: <1368019749-19455-5-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdakF3KSV9QM1E65X+Zipeu2=uA=wpMz2DMGZOCdM--Mdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The MFD subsystem requires drivers to state the size of any platform
> data passed, or it will fail to assign it to the device. This will
> culminate in a NULL platform_data attribute and normally a failure to
> probe() or a kernel Oops.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
