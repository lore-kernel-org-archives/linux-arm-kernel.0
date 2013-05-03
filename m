From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 3 May 2013 16:30:30 +0530
Subject: [PATCH, RFC 21/22] davinci: vpfe_capture needs i2c
In-Reply-To: <1367507786-505303-22-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-22-git-send-email-arnd@arndb.de>
Message-ID: <CA+V-a8sUPwNZq6ed=75_Lq0x_-jy5x4cXcg8BYvZP7b0PQBpcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the patch.

On Thu, May 2, 2013 at 8:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The vpfe_capture driver is implicitly built for three of the davinci
> capture drivers but depends on i2c, so we need to add the dependency
> in Kconfig for each driver using this.
>
>  drivers/media/platform/davinci/vpfe_capture.c: In function 'vpfe_probe':
>  drivers/media/platform/davinci/vpfe_capture.c:1934:2: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
>  drivers/media/platform/davinci/vpfe_capture.c:1934:11: warning: assignment makes pointer from integer without a cast [enabled by default]
>
> Cc: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
