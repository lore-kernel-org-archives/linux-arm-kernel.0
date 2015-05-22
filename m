From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:59:08 +0200
Subject: [PATCH defconfig] ARM: add ARM_SINGLE_ARMV7M in ARMv7-M defconfigs
In-Reply-To: <1432161501-2323-1-git-send-email-stefan@agner.ch>
References: <1432161501-2323-1-git-send-email-stefan@agner.ch>
Message-ID: <4337752.21l0mFDl6H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 00:38:21 Stefan Agner wrote:
> Select ARM_SINGLE_ARMV7M in defconfigs of the converted ARMv7-M
> platforms.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied without the efm32_defconfig change, as I have moved that
into the other patch.

Thanks,

	Arnd
