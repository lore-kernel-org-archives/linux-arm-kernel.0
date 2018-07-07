From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 12:33:22 +0200
Subject: [PATCH v4 2/5] ARM: dts: s5pv210: Add initial DTS for Samsung
 Galaxy S phone
In-Reply-To: <1530958183-10956-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180707103322.45obxwe5jqtfkgqg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2018 at 12:09:40PM +0200, Pawe? Chmiel wrote:
> This DTS file have initial support Samsung Galaxy S phone,
> also known as i9000.
> It belongs to Samsung Aries devices family.
> Initial version have support for:
> - sdcard
> - internal memory
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> 
> --
> Changes from v1:
>   - Added missing commit msg
>   - Removed duplicated and unneeded headers
>   - Added stdout-path
>   - Added information why we hardcode bootargs
> ---
> ---
>  arch/arm/boot/dts/Makefile            |  1 +
>  arch/arm/boot/dts/s5pv210-galaxys.dts | 77 +++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
