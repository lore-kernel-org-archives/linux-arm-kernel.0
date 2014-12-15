From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Dec 2014 23:56:10 +0100
Subject: at91: smc configuration using DT
In-Reply-To: <548F6514.1040706@sigma-star.at>
References: <548F6514.1040706@sigma-star.at>
Message-ID: <2463675.Tt7GDs0rfe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 23:47:48 Richard Weinberger wrote:
> 
> I'm sure I'm missing something.
> 
> One of my boards is still using board files and uses sam9_smc_configure() to
> setup NAND timings. I'd like to convert it to DT but I fail to see how to configure the smc.
> What is the device tree equivalent of sam9_smc_configure()?
> 
> 

I think it's actually missing, see the series "memory: add Atmel EBI
(External Bus Interface) driver" from Boris Brezillon.

	Arnd
