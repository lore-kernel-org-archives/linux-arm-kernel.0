From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 14 Dec 2009 10:21:15 -0200
Subject: sdcard driver porting to linux 2.6.25 from 2.6.19 problem - help
	needed - Freescale IMX 27 processor
In-Reply-To: <OF30B7D58D.4C1F8125-ON65257689.002C49F8-65257689.002C49FD@tcs.com>
References: <OF30B7D58D.4C1F8125-ON65257689.002C49F8-65257689.002C49FD@tcs.com>
Message-ID: <37367b3a0912140421s79cc4e5dy65866db8b4684557@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vadivelan,

On 12/11/09, Vadivelan M <vadivelan.m@tcs.com> wrote:
> Hi ,
>
> ISSUE : SDCARD driver porting problem
> PROCESSOR : IMX27
> PLATFORM : ADS BOARD
> CONTROLLER : INBUILT IMX 27 SDHC controller
>
> I am upgrading the linux from 2.6.19 to 2.6.25
>
> linux kernel is up and mounting the file system properly.
>
> Now i am attaching the drivers. There is no problem in porting the drivers (
> lcd / touch screeen)
>
> while porting the sdcard driver i am getting the error. please find the
> below log. I am using freescale IMX27 Processor - SDHC controller in built.
>

Please, consider using a more up-to-date kernel, SD/MMC card is
working fine on my iMX27 board with kernel 2.6.32.

Best Regards,

Alan
