From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 28 Apr 2011 22:05:32 +0200
Subject: S3C2416, S3C2443 HS-SPI driver?
Message-ID: <201104282205.33100.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

does a driver for spi on s3c2416/s3c2443 SoCs exist somewhere? The one for the 
other s3c24XX SoCs seems to be different.

I did a comparison of the spi-parts of s3c2416 and s3c6400 manuals and they 
seem very much alike in their registers and working descriptions.

The only real differences I found are bit 6 of CH_CFG (High_speed_en) which 
only exists on 2416/2443 and the max values of RxTrigger and TxTrigger are 
greater on 2416 than on 6400 (63 vs 40).

So question for the samsung experts, could the s3c64xx spi-driver be a valid 
starting point for me?

Thanks
Heiko
