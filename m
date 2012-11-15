From: martin@ronetix.at (Martin Peevski)
Date: Thu, 15 Nov 2012 18:34:00 +0200
Subject: Configure the USB device/host on sam9g25 module
Message-ID: <50A51978.7040001@ronetix.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

      Hi,

      I'm working with sam9g25 module placed on sam9x5-ek. sam9g25 has 2 
host USB's and 1 device/host USB (on the micro USB of sam9x5-ek). Both 
USB hosts accept mass storage devices and works correct. It was 
impossible to do 2 things with the USB device/host (placed on the micro 
USB of sam9x5-ek):

      1. Put in it mass storage device - the kernel want not to 
enumerate it and give it an name (for example sda, sdb, ...). What I 
must do in the config file of kernel to be recognized the inserted mass 
storage device?

     2. Connect cable from the micro USB to any of the host USB's and 
detect USB serial gadget.

I tryed to make some configs for both problems in the kernel but it 
don't works. Can you, please, help me solve these problems?
