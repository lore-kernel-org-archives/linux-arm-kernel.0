From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 8 Sep 2015 18:04:28 +0200
Subject: [PATCH linux-next v9 0/3] mfd: flexcom: add a driver for Flexcom
In-Reply-To: <cover.1441118159.git.cyrille.pitchen@atmel.com>
References: <cover.1441118159.git.cyrille.pitchen@atmel.com>
Message-ID: <55EF070C.7020600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Le 01/09/2015 16:46, Cyrille Pitchen a ?crit :
> ChangeLog
> 
> v9:
> - go back to v5 (use the new "atmel,flexcom-mode" DT property).
> - fix the name of the spi node in the DT example: from spi at f8034400 to
>   spi at 400
> - align the fields of the struct platform_driver atmel_flexcom_driver as
>   suggested by Lee Jones.
> 
[...]

Are there any remaining blocking points for this series ?

Best Regards,

Cyrille
