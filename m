From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 23 Oct 2012 19:18:22 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1210231911500.26503@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 22 Oct 2012, Jean Pihet wrote:

> I tried the latest l-o with omap2plus defconfig on my Beagleboard B5
> (ES2.1) and could not reproduce the problem.
> I do not have the I2C error messages at boot, nor at user space start
> up. I tried to read/write the TWL RTC, successfully.
> 
> Another difference is the bootloader images. I have the following:
> - Texas Instruments X-Loader 1.4.2 (Feb  3 2009 - 15:34:17)
> - U-Boot 2009.01-dirty (Feb 19 2009 - 12:22:31)
> Could you send your bootloader images?

Just sent you a link via private E-mail.

> On the PM QoS side the commit 3db11fef moves the I2C code from the
> OMAP PM no-op layer to the PM QoS for CPU and DMA latency, which
> influences the cpuidle states. However CPU_IDLE is not set in
> omap2plus_defconfig so there should not be any effect.
> Do you have CPU_IDLE enabled?

No, it's omap2plus_defconfig.


- Paul
