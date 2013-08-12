From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Aug 2013 01:24:31 -0700
Subject: [PATCH v3 0/9] DRA7xx core support
In-Reply-To: <5208835A.6000506@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com>
 <5208835A.6000506@ti.com>
Message-ID: <20130812082431.GI7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130811 23:47]:
> On Sunday 04 August 2013 09:57 PM, Rajendra Nayak wrote:
> > Changes in v3:
> > -1- Dropped some clock/dpll framework builds for dra7
> > -2- Added all instances of IPs in dtsi file
> > -3- dtsi does a 'disabled' by default and dts enables as needed
> > -4- soc_is_dra7xx() based on DT compatible instead of using ID code
> > 
> > Changes in v2:
> > -1- Fixed minor changelog details
> > -2- Dropped the SRAM support patch since we need to move to drivers/misc/sram.c
> > -3- Added DTS update patches to this series which were earlier posted as
> > part of the data series (Since they don't have much objections as against the
> > other in-kernel data files)
> > -4- Updated the EVM dts file with pin config details for uart/mcspi and i2c
> > 
> > DRA7xx based SoCs' are high-performance, infotainment application devices,
> > based on enhanced OMAP architecture integrated on a 28nm
> > technology.
> > 
> > The DRA7xx family is composed of DRA75x and DRA74x devices.
> > The current device for which the patches add support is the
> > DRA752 SoC.
> > 
> > Most of the core IPs are similar to those found on the OMAP5
> > devices, including the dual cortex-A15 based MPU subsystem,
> > which has helped quite some reuse from existing OMAP5 support.
> > 
> > This series contains only core support patches and none of
> > the PRCM and hwmod data needed for the device to boot.
> 
> Tony, any chance of this series making it to 3.12?

Looks OK to me, want to do a pull request against -rc5 for me?

Regards,

Tony
