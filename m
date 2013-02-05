From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 5 Feb 2013 13:38:27 +0100
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130205123827.GG20242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y

Hi Ezequiel

Maybe it makes sense to provide a patch to mvebu_defconfig to add 
CONFIG_MTD_M25P80=y ?

	Andrew
