From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 1 Jun 2015 06:34:47 +0300
Subject: [PATCH] ARM: sti: fix documentation reference
In-Reply-To: <5552F5EB.6020604@st.com>
References: <d0f22751247391d5f7f1b8ebec507a8e0c4b4943.1430395589.git.baruch@tkos.co.il>
 <20150512185649.GB2558@tarshish> <5552F5EB.6020604@st.com>
Message-ID: <20150601033447.GS2282@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice, STi maintainers,

On Wed, May 13, 2015 at 08:57:47AM +0200, Patrice Chotard wrote:
> On 05/12/2015 08:56 PM, Baruch Siach wrote:
> >On Thu, Apr 30, 2015 at 03:06:29PM +0300, Baruch Siach wrote:
> >>Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >>---
> >>  arch/arm/mach-sti/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> >>index 3b1ac463a494..f7d42ddf95f6 100644
> >>--- a/arch/arm/mach-sti/Kconfig
> >>+++ b/arch/arm/mach-sti/Kconfig
> >>@@ -17,7 +17,7 @@ menuconfig ARCH_STI
> >>  	help
> >>  	  Include support for STiH41x SOCs like STiH415/416 using the device tree
> >>  	  for discovery
> >>-	  More information at Documentation/arm/STiH41x and
> >>+	  More information at Documentation/arm/sti and
> >>  	  at Documentation/devicetree
> >Ping?
>
> Sorry for the late answer
> 
> Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks. One last ping.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
