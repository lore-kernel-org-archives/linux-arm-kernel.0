From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 2 Mar 2013 11:43:38 +0000
Subject: [PATCH 1/4] ARM: s3c24xx: Removed unneeded dependency on
 ARCH_S3C24XX for boards
In-Reply-To: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
Message-ID: <201303021143.38390.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 March 2013, Alexander Shiyan wrote:
> Board options are already under "if ARCH_S3C24XX" condition, so
> additional dependencies on this symbol can be removed.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Hi Alexander,

Is this just a cosmetic change that has no other consequences, or do you
have other follow-up patches that depend on patches 1-3?

	Arnd
