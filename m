From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 14 Jul 2016 13:13:48 +0200
Subject: [PATCH v3 0/3] pci: Aardvark PCIe controller driver for Marvell
 Armada 3700
In-Reply-To: <20160707224403.3279d807@free-electrons.com>
References: <1467279152-5717-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160707224403.3279d807@free-electrons.com>
Message-ID: <CAPv3WKcY3wWsbqkwjH7e51jDpgSxFtru=f=Sv3AXabaHEEr0XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I tested MSI's, Legacy IRQ's and stability problems with configuration
space access - everything works fine, so
Tested-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin

2016-07-07 22:44 GMT+02:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Hello Bjorn,
>
> On Thu, 30 Jun 2016 11:32:29 +0200, Thomas Petazzoni wrote:
>
>> This is the third iteration of the patch series that adds a PCIe
>> controller driver for the Aardvark PCI controller, which is used on
>> Marvell Armada 3700.
>
> Have you had the chance to look into this third iteration, which
> hopefully integrates the feedback you made during your review of the
> second version?
>
> I was hoping to get this in time for 4.8, so if you have any comments,
> do not hesitate to let me know so that I can address them.
>
> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
