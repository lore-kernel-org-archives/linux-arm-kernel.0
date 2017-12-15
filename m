From: sza@esh.hu (=?utf-8?B?U3plbXrFkSBBbmRyw6Fz?=)
Date: Fri, 15 Dec 2017 11:21:21 +0100
Subject: [RFC PATCH 0/5]  Introduce PMSAv8 memory protection unit
In-Reply-To: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <0B16DB97-D4E6-4DEE-A03F-FD215475C448@esh.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On 2017. Dec 13., at 18:02, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> 
> Hi,
> 
> This series is an attempt to add support for PMSAv8 MPU defined by
> ARMv8R/M architecture.
> 
> I'm have a doubt about adding dedicated config option, so both v7 and
> v8 versions of PMSA are covered with CONFIG_MPU, but I'd glad to hear
> what people think of it.
> 
> Thanks!
> 
> Vladimir Murzin (5):
>  ARM: NOMMU: Move PMSAv7 MPU under it's own namespace
>  ARM: NOMMU: Reorganise __setup_mpu
>  ARM: NOMMU: Postpone MPU activation till __after_proc_init
>  ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment restrictions
>  ARM: NOMMU: Support PMSAv8 MPU
> 

I?ve tested this series on my Atmel armv7m board, and it doesn?t break anything on my side.
(My test setup is running kernel from SDRAM, with rootfs on SDcard, so no XIP was tested)

FWIW, you can add my Tested-by for patches 1-4.

Thanks!

Regards,
Andras
