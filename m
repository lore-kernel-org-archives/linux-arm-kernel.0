From: axel.lin@gmail.com (Axel Lin)
Date: Thu, 01 Dec 2011 20:58:24 +0800
Subject: [linux-next] drivers/i2c/busses/i2c-nuc900.c build error
Message-ID: <1322744304.7477.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I got below build error on linux-next 20111201.
  CC      drivers/i2c/busses/i2c-nuc900.o
drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
drivers/i2c/busses/i2c-nuc900.c:600: error: request for member 'apbfreq' in something not a structure or union
make[3]: *** [drivers/i2c/busses/i2c-nuc900.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Regards,
Axel
