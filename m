From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 May 2014 14:32:28 +0200
Subject: How to fix SDIO Operating Frequency in iMX6 device tree
In-Reply-To: <CA+dawz2qxiVBzKkJVvMMU9wtfLajzN-z=ApmnZ3g8h42AncERQ@mail.gmail.com>
References: <CA+dawz2qxiVBzKkJVvMMU9wtfLajzN-z=ApmnZ3g8h42AncERQ@mail.gmail.com>
Message-ID: <20140515123228.GI5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashutosh,

On Thu, May 15, 2014 at 11:19:01AM +0530, Ashutosh Singh wrote:
> I want to fixed the SDIO Operating Frequency to 25MHz for one of the
> SDIO based Wifi module connected to Card slot.
> How can i fixed it in my dtsi file. I am using iMX6 quard based custom board.

Set the max-frequency property in the usdhc device node.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
