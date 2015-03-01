From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 01 Mar 2015 20:52:55 +0100
Subject: [PATCH v3 0/2] WM8505/WM8650 DT fixes for SD card controller
In-Reply-To: <1425226007-2757-1-git-send-email-rvolkov@v1ros.org>
References: <1423130878-3894-1-git-send-email-v1ron@v1ros.org>
 <1425226007-2757-1-git-send-email-rvolkov@v1ros.org>
Message-ID: <2119510.55A8Br1LeL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 March 2015 19:06:45 Roman Volkov wrote:
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

According to the MAINTAINERS file, Tony Prisk should be the person to
pick them up, but he was not the recipient of the mail.

	Arnd
