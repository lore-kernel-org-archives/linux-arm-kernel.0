From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 15:29:29 +0100
Subject: [PATCH v3 RESEND 0/2] WM8505/WM8650 DT fixes for SD card
 controller
In-Reply-To: <1451655492-2569-1-git-send-email-v1ron@mail.ru>
References: <1451655492-2569-1-git-send-email-v1ron@mail.ru>
Message-ID: <7786478.TezhYjHkEF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 January 2016 16:38:10 Roman Volkov wrote:
> From: Roman Volkov <rvolkov@v1ros.org>
> 
> This patch set enables SD controller support for WM8650 and
> fixes minor errors in WM8505 Device Tree file.
> 
> Changes in v3:
> 1. Add minor fixes for WM8505 SDHC node
> 
> Tested on both WM8505 and WM8650.
> 
> Roman Volkov (2):
>   dts: vt8500: Add SDHC node to DTS file for WM8650
>   dts: vt8500: Fix errors in SDHC node for WM8505
> 
>  arch/arm/boot/dts/wm8505.dtsi | 4 ++--
>  arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> -- 
> Hi maintainers, I see my previous versions were not applied. Could this
> little patch set be applied for the linux-next? I don't think this is new
> functionality, this must be considered as bugfix for existing Device Tree.
> 
> Any other suggestions?
> 

Applied both to next/dt, thanks a lot for following up!

Let me know if you think this should go into stable backports as well,
I did not apply it to the fixes branch as you don't have a
'Cc: stable at vger.kernel.org' tag and it has never worked so far.

	Arnd
