From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 10:49:55 +0200
Subject: [PATCH v3 9/9] ARM: s5pv210_defconfig: Enable options needed to
 boot typical Linux distro
In-Reply-To: <1530901970-14972-10-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-10-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180707084955.qsurxetcqafebazn@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 08:32:50PM +0200, Pawe? Chmiel wrote:
> This commit enables few options which are required to boot
> typical Linux distro. It was tested by booting ArchLinux ARM
> from sdcard.
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
