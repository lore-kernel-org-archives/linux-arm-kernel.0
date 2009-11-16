From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Mon, 16 Nov 2009 10:32:02 +0100
Subject: ARM kirkwood: how to run kirkwood_pcie_init() from kernel module
Message-ID: <200911161032.02873.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

sorry for disturbing and also sorry for my - maybe strange - question ;)

I've got the following problem:

I want to boot my fpga before I start the pci layer.
To achieve this it is necessary to start the pci layer somewhat after flashing my fpga.

So what I need is to run kirkwood_pcie_init() from inside my (flashing) driver.
Do you know a way how to realize this?

The header common.h isn't meant to include it from anywhere else than from kirkwood *_setup.c files, right?

Is it possible to do a EXPORT_SYMBOL(kirkwood_pcie_init) somehow?

I've tried it allready but get linker warnings and function isn't called...

Do you have an idea how I can do that?

Many many thanks in advance,
Dieter
