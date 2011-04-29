From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 29 Apr 2011 09:15:39 +0530
Subject: S3C2416, S3C2443 HS-SPI driver?
In-Reply-To: <201104282205.33100.heiko@sntech.de>
References: <201104282205.33100.heiko@sntech.de>
Message-ID: <BANLkTikieLM9yyDttFvo4CvmmxjG9=m6FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 1:35 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi,
>
> does a driver for spi on s3c2416/s3c2443 SoCs exist somewhere? The one for the
> other s3c24XX SoCs seems to be different.
>
> I did a comparison of the spi-parts of s3c2416 and s3c6400 manuals and they
> seem very much alike in their registers and working descriptions.
>
The spi_s3c64xx.c has designed to accomodate such slight variations in
controllers.
For the same 'template' controller, the driver can make it work if
passed appropriate
configuration parameters via 'struct s3c64xx_spi_info'
