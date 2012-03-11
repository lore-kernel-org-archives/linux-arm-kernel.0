From: marc@cpdesign.com.au (Marc Reilly)
Date: Sun, 11 Mar 2012 12:29:59 +1100
Subject: mfd: mc13xxx: add I2C support, V2
Message-ID: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,                                                                                                                            

This series (based on Samuel's mfd-2.6/for-next) adds I2C support for the
mc13xxx family PMICs. Thanks to Oscar for adding dt support for the I2C driver.                       

V2 lets both I2C and SPI support be enabled at the same time and limits the 
scope of common definitions by using a private include header rather than global
one.
The only issue from V1 [0] not addressed is the use of regmap - mainly, I don't
have the time. I accept that this is a lame excuse but hope that use of regmap 
can come later if it is required.

Cheers,
Marc                        

[0] http://www.spinics.net/lists/linux-i2c/msg06992.html
