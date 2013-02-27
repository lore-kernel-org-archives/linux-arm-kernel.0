From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Feb 2013 13:57:07 +0530
Subject: [PATCH 1/4] spi/davinci: fix module build error
In-Reply-To: <1361789050-637-2-git-send-email-prakash.pm@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
 <1361789050-637-2-git-send-email-prakash.pm@ti.com>
Message-ID: <512DC35B.20501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> Fix below module build error:
> 
>   CC [M]  drivers/spi/spi-davinci.o
> drivers/spi/spi-davinci.c:774:1: error: '__mod_of_device_table' aliased
> to undefined symbol 'davini_spi_of_match'
> drivers/spi/spi-davinci.c:774:1: error: '__mod_of_device_table' aliased
> to undefined symbol 'davini_spi_of_match'
> make[2]: *** [drivers/spi/spi-davinci.o] Error 1
> make[1]: *** [drivers/spi] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
