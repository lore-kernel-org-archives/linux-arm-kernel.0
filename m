From: marex@denx.de (Marek Vasut)
Date: Sat, 14 Jun 2014 21:01:30 +0200
Subject: [PATCH v3 2/4] crypto: Update makefile and Kconfig for Security
 System
In-Reply-To: <1402404197-4236-3-git-send-email-clabbe.montjoie@gmail.com>
References: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
 <1402404197-4236-3-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <201406142101.30546.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 10, 2014 at 02:43:15 PM, LABBE Corentin wrote:
> Add necessary changes for configuring and compiling the Security System
> driver.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/crypto/Kconfig  | 91
> +++++++++++++++++++++++++++++++++++++++++++++++++ drivers/crypto/Makefile
> |  1 +
>  2 files changed, 92 insertions(+)

This should be part of 1/4, otherwise 1/4 just adds dead code.

Best regards,
Marek Vasut
