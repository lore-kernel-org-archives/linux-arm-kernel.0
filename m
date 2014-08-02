From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Aug 2014 14:57:46 +0200
Subject: [PATCH v6 06/10] ARM: dts: Clean up exynos5250-smdk5250
In-Reply-To: <1406940750-15880-7-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <1406940750-15880-7-git-send-email-afaerber@suse.de>
Message-ID: <53DCE04A.1040803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.08.2014 02:52, Andreas F?rber wrote:
> Use the new style for referencing inherited nodes and use symbolic names.
> 
> Goal is the alignment of all exynos5250 based device trees for comparison.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v5 -> v6:
>  * Renamed node label codec -> mfc for alignment with "add System MMU nodes"
>  * Rebased for leaving dp_hpd in .dtsi
>  
>  v5: New
>  Follow-up after adding dp_hpd pinctrl node new-style.
> 
>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 632 +++++++++++++++---------------
>  1 file changed, 318 insertions(+), 314 deletions(-)

This in fact ends up with empty diff after compiling and decompiling the
dts, so obviously will not break anything. :)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
