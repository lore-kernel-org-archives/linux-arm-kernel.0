From: a.lombardinilo@sintau.it (a.lombardinilo)
Date: Wed,  9 Mar 2016 11:05:55 +0100
Subject: Kirkwood dts spi-gpio
Message-ID: <O3RO1V$CF721D4D7AC56BB19237E5BFE0260DB6@sintau.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My platform is based on the Marvell kirkwood 88e6281.
I'm updating the kernel from version 3.3.8 to version 3.18.27.
I'm new in dts and I have some problem on the configuration in the spi-gpio.
I'm using the spi-gpio for can interface (MCP2510).

Can anyone provide an example of configuration/settings?

The hardware connection is the following:
?- CAN_SPI_CS -> MPP39
?-?CAN_SPI_SCK -> MPP39
?-?CAN_SPI_MISO -> MPP39
?-?CAN_SPI_MOSI -> MPP39
?-?CAN_SPI_IRQ -> MPP39
?-?CAN_SPI_RST -> MPP39
