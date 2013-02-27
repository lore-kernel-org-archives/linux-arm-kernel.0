From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 11:47:30 +0100
Subject: [PATCH v2 2/3] crypto: sahara: Add driver for SAHARA2 accelerator.
In-Reply-To: <1361961711-4603-3-git-send-email-javier.martin@vista-silicon.com>
References: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
 <1361961711-4603-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <10560881.xkCvi82rco@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013 11:41:50 Javier Martin wrote:
> SAHARA2 HW module is included in the i.MX27 SoC from
> Freescale. It is capable of performing cipher algorithms
> such as AES, 3DES..., hashing and RNG too.
> 
> This driver provides support for AES-CBC and AES-ECB
> by now.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
