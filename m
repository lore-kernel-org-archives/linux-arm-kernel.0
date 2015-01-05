From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Jan 2015 19:05:31 +0100
Subject: [PATCH v4 1/1] add support for Seagate BlackArmor NAS220
In-Reply-To: <20141228104654.GA11638@anne>
References: <20141215203855.GA28940@anne>
 <20141228104654.GA11638@anne>
Message-ID: <20150105180531.GA13910@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 28, 2014 at 11:46:54AM +0100, Evgeni Dobrev wrote:
> This patch adds support for Seagate BlackArmor NAS220.
> 
> The Seagate BlackArmor NAS 220 is a NAS system based on Marvell 88f6192. It has
> 32MB NAND and 128MB DRAM. It has two SATA slots, one Gigabit Ethernet port, two
> USB 2.0 ports, two buttons and three LEDs. There is a serial port available on
> the CN5 connector on the board (1 - TX, 4 - RX, 6 - GND).
> 
> The only functionality still not implemented is the bi-color led on the front
> panel (status). Pins mpp22 and mpp23 control this led. Setting mpp22 to high and
> mpp23 to low results in orange color. Setting mpp22 to low and mpp23 to high
> results in blue color.
> 
> The third led is wired to show the SATA activity on the two drives.
> 
> Signed-off-by: Evgeni Dobrev <evgeni@studio-punkt.com>

Hi Evgeni

I added this to mvebu/dt and will submit it for the next merge window.

Thanks
	Andrew
