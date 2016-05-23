From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 23 May 2016 09:03:01 +0200
Subject: [PATCH 0015/1529] Fix typo
In-Reply-To: <20160521113722.32053-1-andrea.gelmini@gelma.net>
References: <20160521113722.32053-1-andrea.gelmini@gelma.net>
Message-ID: <20160523090301.3cdbd523@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 21 May 2016 13:37:22 +0200 Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> index 3e36c1d..616428a 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -8,7 +8,7 @@ use to analyze system performance, to make behaviors visible and to count
>  usages of each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D, MFC).
>  The Exynos PPMU driver uses the devfreq-event class to provide event data
>  to various devfreq devices. The devfreq devices would use the event data when
> -derterming the current state of each IP.
> +determing the current state of each IP.
>  
s/determing/determine/


Lothar Wa?mann
