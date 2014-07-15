From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 15 Jul 2014 22:00:30 +0200
Subject: [PATCH 2/3] spi: s3c64xx: validate s3c64xx_spi_csinfo before using
In-Reply-To: <53C569A8.1000103@samsung.com>
References: <1405426860-18404-1-git-send-email-ch.naveen@samsung.com>
 <1405426860-18404-3-git-send-email-ch.naveen@samsung.com>
 <53C569A8.1000103@samsung.com>
Message-ID: <53C5885E.2020609@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Naveen,

On 07/15/2014 07:49 PM, Tomasz Figa wrote:
> 
> In general, I liked previous version of this series much more, as it was
> doing what it should as opposed to this one.
> 
> Best regards,
> Tomasz
> 

I agree with Tomasz. I think version v6 of your series was (almost) correct
while this is one is not. You only had to address Mark's concerns about using
gpio_is_valid(spi->cs_gpio).

Also, you need to work out your commit messages since I they are still not
clearly explaining the motivation for the changes. You are explaining what the
patches are changing but you have to explain why the changes are needed in the
first place.

Best regards,
Javier
