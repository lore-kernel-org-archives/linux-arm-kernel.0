From: marc@cpdesign.com.au (Marc Reilly)
Date: Thu, 15 Mar 2012 07:43:04 +1100
Subject: mc13xxx: add I2C support (now with regmap), V3
Message-ID: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series (against mfd-2.6/for-next) changes the mc13xxx driver to use 
regmap and adds I2C support. It generally goes about this the same way as 
the previous 2 versions, but now uses regmap.

I am unable to test SPI functionality, but the I2C stuff works. It would be
great if someone could test the SPI side again.

The first 2 patches add required support to regmap for the mc13xxx register
format(s), I've included them here for convenience.
@Mark B: I also have some versions of these that apply against regmap/for-next.

Cheers,
Marc
