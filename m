From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Nov 2011 15:31:02 +0100
Subject: [PATCH v8] AT91: Add a driver for the ADC
In-Reply-To: <1321611160-3685-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1321611160-3685-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <4ECBB226.4080404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

So, I guess that we have a pretty good driver with that version. What
can we do for the inclusion in the kernel now ?

Maxime

On 18/11/2011 11:12, Maxime Ripard wrote:
> Hi all,
> 
> This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
> the at91sam9g20ek and should work on sam9g45 as well.
> 
> For now, it only reads values when asked for by sysfs, but eventually will
> support hardware triggers and more boards.
> 
> This patchset is based on the "[PATCH 0/6 V2] IIO: Out of staging step 1: The
> core" patchset from Jonathan Cameron, applied on top of 3.1
> 
> Improvements from v7:
>   - Fix the channels mask bug
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
