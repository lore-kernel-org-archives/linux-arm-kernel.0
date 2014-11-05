From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 5 Nov 2014 21:39:18 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <201411052137.31452@pali>
References: <20141104205117.GA17606@amd>
 <20141105011122.GA30622@earth.universe>
 <20141105203151.GA24636@amd> <201411052137.31452@pali>
Message-ID: <20141105203918.GA29199@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Hello, have you enabled CONFIG_PHONET?

Yes:

CONFIG_PHONET=y

And this:

# SPI Protocol Masters                                                                            
#                                                                                                 
# CONFIG_SPI_SPIDEV is not set                                                                    
# CONFIG_SPI_TLE62X0 is not set                                                                   
# CONFIG_SPMI is not set                                                                          
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#                                                                                                 
# HSI controllers                                                                                 
#                                                                                                 
CONFIG_OMAP_SSI=y
CONFIG_OMAP_SSI_PORT=y

#                                                                                                 
# HSI clients                                                                                     
#                                                                                                 
CONFIG_NOKIA_MODEM=y
CONFIG_SSI_PROTOCOL=y
CONFIG_HSI_CHAR=y
CONFIG_HSI_CMT_SPEECH=y

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
