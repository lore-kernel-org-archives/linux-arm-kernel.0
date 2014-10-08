From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 21:30:09 +0200
Subject: [PATCH v2 0/7] ARM: meson: add support for Meson8
In-Reply-To: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
References: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
Message-ID: <59241134.gsbhNQV8Wa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 October 2014 23:59:12 Beniamino Galvani wrote:
> 
> this patchset introduces support for Amlogic Meson8, which is a family
> of quad-core Cortex-A9 SoCs used in tablets and set-top boxes.
> 
> Changes since v1:
>  - reused the existing DT machine definition and renamed it to be more
>    generic
>  - added L2 cache support

Looks all good to me

Acked-by: Arnd Bergmann <arnd@arndb.de>
