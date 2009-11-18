From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 17 Nov 2009 21:10:43 -0600
Subject: ARM kirkwood: how to run kirkwood_pcie_init() from kernel module
In-Reply-To: <200911161032.02873.dk-arm-linux@gmx.de>
References: <200911161032.02873.dk-arm-linux@gmx.de>
Message-ID: <c70ff3ad0911171910t2231317aw154ba6e455ca3511@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

please note that this function linked into the init section.

On Mon, Nov 16, 2009 at 3:32 AM, Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> Hi all,
>
> sorry for disturbing and also sorry for my - maybe strange - question ;)
>
> I've got the following problem:
>
> I want to boot my fpga before I start the pci layer.
> To achieve this it is necessary to start the pci layer somewhat after flashing my fpga.
>
> So what I need is to run kirkwood_pcie_init() from inside my (flashing) driver.
> Do you know a way how to realize this?
>
> The header common.h isn't meant to include it from anywhere else than from kirkwood *_setup.c files, right?
>
> Is it possible to do a EXPORT_SYMBOL(kirkwood_pcie_init) somehow?
>
> I've tried it allready but get linker warnings and function isn't called...
>
> Do you have an idea how I can do that?
>
> Many many thanks in advance,
> Dieter
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
