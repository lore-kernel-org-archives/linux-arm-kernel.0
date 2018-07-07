From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 12:29:36 +0200
Subject: [PATCH v4 1/5] ARM: dts: s5pv210: Add initial DTS for Samsung
 Aries based phones
In-Reply-To: <1530958183-10956-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180707102936.eg5htvnx5sikgdwq@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2018 at 12:09:39PM +0200, Pawe? Chmiel wrote:
> This DTS file have initial support Samsung Aries based phones.
> Initial version have support for:
> - sdcard
> - internal memory (present only on non 4g variant)
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Fix dts warnings
> 
> Changes from v2:
>   - Restored pinctrl nodes order
>   - Correct order of nodes
> 
> Changes from v1:
>   - Removed duplicated and unneeded headers
>   - Corrected node names
>   - Added missing spaces
>   - Removed unneeded pinctrl and sorted entries
>   - Set correct interrupt type for max8998 pmic
>   - Add missing regulators
> ---
> ---

Thanks, applied.

Best regards,
Krzysztof
