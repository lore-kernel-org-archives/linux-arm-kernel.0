From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 17:21:51 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: enable some newly added crypto
 modules
In-Reply-To: <1487183412-25261-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487183412-25261-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <2984474.o4uKWU7966@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 15, 2017 6:30:12 PM CET Ard Biesheuvel wrote:
> Enable the new accelerated CRC32(C), CRC-T10DIF and ChaCha20 drivers
> as modules for multi_v7_defconfig builds.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 

Applied to next/defconfig, thanks!

	Arnd
