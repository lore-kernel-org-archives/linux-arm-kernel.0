From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 4 Feb 2013 20:03:26 +0100
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <20130204165119.GA2440@localhost>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130204165119.GA2440@localhost>
Message-ID: <20130204190326.GA20212@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 01:51:20PM -0300, Ezequiel Garcia wrote:
> Hi,
> 
> This patchset adds support for the SPI controller
> available in Armada 370 and Armada XP SoC.

Hi Ezequiel

Do any of the boards we have with mainline support have any devices on
the SPI busses? Its hard to test otherwise.

    Thanks
	Andrew
