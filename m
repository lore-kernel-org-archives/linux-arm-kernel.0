From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 10:49:43 +0200
Subject: [PATCH v3 8/9] ARM: s5pv210_defconfig: Enable drivers for
 Samsung Aries based phones
In-Reply-To: <1530901970-14972-9-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-9-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180707084943.omc3efkrxbqxaofx@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 08:32:49PM +0200, Pawe? Chmiel wrote:
> Enable config options required for Samsung Aries based phones.
> ARM_APPENDED_DTB is also needed, because stock bootloader
> does not support loading dtb files.
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
