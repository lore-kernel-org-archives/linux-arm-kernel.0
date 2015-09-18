From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 18 Sep 2015 17:31:37 +0200
Subject: [PATCH V6 0/3] nvmem: add ocotp support for i.MX23 and i.MX28
In-Reply-To: <1439418116-1833-1-git-send-email-stefan.wahren@i2se.com>
References: <1439418116-1833-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <55FC2E59.5030504@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Am 13.08.2015 um 00:21 schrieb Stefan Wahren:
> This patch series brings read-only support for the On-Chip OTP cells
> in the i.MX23 and i.MX28 processor.
>
> changes in V6:
> - add COMPILE_TEST to dependancy
> - remove unnecessary headers
> - enable clock during read operation
> - fix module license
>
> changes in V5:
> - rebase to char-misc-next
> - add nvmem prefix to module name
> - set status in dtsi files
>
> changes in V4:
> - rename fsl_ocotp.c to mxs-ocotp.c
> - adapt driver to use NVMEM framework V7
> - take care of hbus clock
> - increase too small timeout
> - implement a wait function
> - use defines from stmp_device.h
> - remove owner init
> - more code cleanup
>
> changes in V3:
> - drop write support
> - take care of i.MX23 which has less registers
> - drop unnecessary header file
> - move static variables into driver data
> - add devicetree probing
> - fix missing bank closing in error case
> - use kobj from platform device for sysfs
> - add SYSFS to Kconfig
> - add binding file
> - code cleanup
>
> Stefan Wahren (3):
>   DT: nvmem: add binding for mxs-ocotp
>   nvmem: add driver for ocotp in i.MX23 and i.MX28
>   ARM: mxs: enable ocotp for i.MX23 and i.MX28

the merge window is closed and patch #3 has been applied by Shawn.

Is it possible for you to apply the rest of this series to char-misc-next?

Kind regards
Stefan
