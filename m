From: martin@ronetix.at (Martin Peevski)
Date: Thu, 13 Dec 2012 11:55:36 +0200
Subject: sam9x5 one-wire driver not founding the device
Message-ID: <50C9A618.2090903@ronetix.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

     Hello, I'm working with sam9x35-cm on sam9x35-ek. Building Linux 
Kernel v.2.6.39+ and want to add W1 Dallas driver for communication with 
the sam9x35-cm DS2431 EEPROM. The driver is built but no device is 
found. Can you, please, help me?

     I'm trying to locate the source and find is the pin selected for 
communication routed correctly on the board but no success to date. Can 
you tell me where is defined in the source the pin used for W1 
communication?

     Isn't selected the correct pin when I make at91sam9x5ek_defconfig 
for the Kernal configuring?
