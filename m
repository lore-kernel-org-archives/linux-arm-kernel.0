From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Mar 2015 16:37:49 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150317162831.GB8656@n2100.arm.linux.org.uk>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <20150317162831.GB8656@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB0561681457FA1AE36384052B8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > DEBUG_LL=y may help you here. It's easier than doing a post-mortem 
> > analysis on __log_buf from U-Boot.
> > As we still have anti-social platforms, you best remove all non-SCIF 
> > default addresses from the DEBUG_UART_PHYS section in arch/arm/Kconfig.debug though.
> 
> Or enter the appropriate address directly, which is what's intended in the long term.  Having zillions of defaults in Kconfig is not that much better from what we had before...

I would say having to manually enter an address is acceptable for debugging (in my opinion)

Chris
