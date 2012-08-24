From: carlo_bastelli@yahoo.it (Bastelli Carlo (yahoo))
Date: Fri, 24 Aug 2012 15:57:08 +0100 (BST)
Subject: SLAVE Side SPI kernel driver development
Message-ID: <1345820228.87750.YahooMailNeo@web29604.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, I'm Carlo, I have a difficult task at work, my boss asked me to 
develop
 a driver SPI slave side on embedded ARM processor running Linux. 
Precisely linux occur on the SPI bus as a slave, not master as required 
by the hierarchical structure of the current kernel. The new driver 
will
 receive via interrupt and respond when selected by its chip select. Can
 anyone suggest the best way to develop this driver?. Personally, I 
have identified two main roads, the first if possible to exploit the 
structure SPI master driver, with a few tricks that now I can not 
define. The second most radical, write a driver for a UART like, but 
managing the SPI device.
Thank you for any suggestions or examples.

Carlo Bastelli
