From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 11 Oct 2013 15:13:39 +0200
Subject: [PATCH 3/5] [media] s3c-camif: Use CONFIG_ARCH_S3C64XX to check
 for S3C64xx support
In-Reply-To: <1380392497-27406-3-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
 <1380392497-27406-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <5257F983.9060904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2013 08:21 PM, Tomasz Figa wrote:
> Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
> the Kconfig entry of s3c-camif driver to use the proper way of checking
> for S3C64xx support - CONFIG_ARCH_S3C64XX.
>
> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
