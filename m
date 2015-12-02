From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 14:44:52 +0100
Subject: [PATCH 2/5] ARM: config: Reenable DSA in multi_v5_defconfig
In-Reply-To: <1449012812-9779-3-git-send-email-andrew@lunn.ch>
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <1449012812-9779-3-git-send-email-andrew@lunn.ch>
Message-ID: <5178408.9v5CNQ5szW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 00:33:29 Andrew Lunn wrote:
> DSA now depends on switchdev. Enable it, and re-enable DSA and its
> drivers, which were removed when multi_v5_defconfig was regenerated.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 

Ok, you already had that. The rest of the series looks good too.

	Arnd
