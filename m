From: sambasiva.a@siennaecad.com (sambasiva.a at siennaecad.com)
Date: Fri, 5 Apr 2013 16:49:42 +0530 (IST)
Subject: Regarding the SPI initialization problem on sam9x5 2000 boards in
 linux kernel 3.2.6
Message-ID: <48262.115.249.69.209.1365160782.squirrel@mail.siennaecad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

when i execute the following command the sam9x5 2000 board will hang.

echo "test" > /dev/spidev0.1
I am facing this problem once  ported the sam9x5 code from 2.6.39 to 3.2.6
kernel .

Could you please tell me anyone how to move out from the hang state.

Regards
Samba
