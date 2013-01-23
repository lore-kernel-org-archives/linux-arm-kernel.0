From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:56:53 +0800
Subject: [PATCH] [ARM] spitz/pxa: Minor naming fixes in spitz.c
In-Reply-To: <1355254812-14500-1-git-send-email-dromede@gmail.com>
References: <1355254812-14500-1-git-send-email-dromede@gmail.com>
Message-ID: <CAN1soZwRRof8NFdMAd6k4tftLfGwMhh8YHuvuvszemL7pq69Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 3:40 AM,  <dromede@gmail.com> wrote:
> From: Marko Katic <dromede.gmail.com>
>
> The NAND init section was erroneously named "Framebuffer".
> Gpio expander section should really be called "I2C devices"
> since it contains all i2c init code.
>
> Signed-off-by: Marko Katic <dromede@gmail.com>
> ---
>  arch/arm/mach-pxa/spitz.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
Applied.

Thanks
Haojian
