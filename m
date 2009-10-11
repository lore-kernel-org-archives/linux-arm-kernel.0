From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 11 Oct 2009 09:20:05 +0200
Subject: [RFC] Re-order of PXA-based platforms in Kconfig and Makefile
In-Reply-To: <f17812d70910100901m57999415mecc637a05921e78a@mail.gmail.com>
References: <f17812d70910100901m57999415mecc637a05921e78a@mail.gmail.com>
Message-ID: <4AD18725.9060500@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric

Eric Miao wrote:
> All,
> 
> I've listed almost all the PXA based platforms currently existing in mainline
> kernel as below. Due to the naming mess in Kconfig and Makefile, I'd like to
> get them sorted in the following order:
> 
>   1. By category:
>      Intel/Marvell Dev Platforms, followed by 3rd party platforms, followed
>      by end-user products (this is to ensure the commonly referenced platforms
>      will appear first)
> 
>   2. By vendor name in alphabetic within each category
>      (this is to ensure code reuse and similar platforms can be grouped as
>       much as possible)
> 
> Patch is attached, and any problems, please let me know.

I'd also add "comment <platform type>" to the Kconfig. This will make it
slightly more readable.

> - eric
> 
> Vendor		Board Name	Processor	Maintaneance Status
> Intel/Marvell	Lubbock		PXA255		Eric Miao
> Intel/Marvell	Mainstone	PXA27x		Eric Miao
> Intel/Marvell	Zylonite	PXA3xx		Eric Miao
> Intel/Marvell	Littleton	PXA3xx		Eric Miao
> Intel/Marvell	TavorEVB	PXA93x		Eric Miao
> Intel/Marvell	SAAR		PXA93x		Eric Miao
> 			
> Accelent	IDP		PXA255		Cliff Brake <cliff.brake@gmail.com>
> Arcom/Eurotech	VIPER		PXA255		Marc Zyngier <maz@misterjones.org>
> Community	Balloon3	PXA27x		Jonathan McDowell <noodles@earth.li>
> Cogent		CSB726		PXA25x		Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> CompuLab	EM_X270		PXA27x		Mike Rapoport <mike@compulab.co.il>
> CompuLab	EXEDA		PXA27x		Mike Rapoport <mike@compulab.co.il>
> CompuLab	ARMCORE		PXA25x/PXA27x	Mike Rapoport <mike@compulab.co.il>
> CompuLab	CM_X300		PXA3xx		Mike Rapoport <mike@compulab.co.il>
> Gumstix		Gumstix		PXA25x		Unknown (Jaya Kumar did some contribution)
> Intel Research	MOTE2		PXA27x		Unknown (initial submission by Jonathan Cameron)
> Intel research	Stargate2	PXA27x		Unknown (initial submission by
> Jonathan Cameron)
> Iskratel	XCEP		PXA25x		Unknown (initial submission by:
> 							Ale? Bardorfer <ales.bardorfer@i-tech.si>
> 							Michael Abbott <michael.abbott@diamond.ac.uk>
> 							Matej Kenda <matej.kenda@i-tech.si>)
> Keith and Koep	Trizeps4	PXA27x		Jurgen Schindele (linux at schindele.name)
> LogicPD		LPD270		PXA27x		Unknown
> Phytec		PCM027		PXA27x		Penguitronix
> Toradex		Colibri		PXA27x/PXA3xx	Daniel Mack <daniel@caiaq.de>
> 			
> HP		HX4700		PXA27x		Philipp Zabel <philipp.zabel@gmail.com>
> HP		H5000		PXA27x		Unknown (initial submission by:
> 							Anton Vorontsov <cbouatmailru@gmail.com>
> 							Milan Plzik <milan.plzik@gmail.com>)
> HTC		Himalaya	PXA27x		Zbynek Michl <Zbynek.Michl@seznam.cz>
> HTC		Magician	PXA27x		Philipp Zabel <philipp.zabel@gmail.com>
> Mitac		MioA701		PXA27x		Robert Jarzmik <robert.jarzmik@free.fr>
> Motorola	EZX		PXA27x		Daniel Ribeiro <drwyrm@gmail.com>
> 						Stefan Schmidt <stefan@openezx.org>
> 						Harald Welte <laforge@openezx.org>
> NEC		MP900C		PXA27x		Initial submission by Kristoffer Ericson
> <Kristoffer.Ericson@gmail.com>
> Palm		Palm PDA	PXA25x/PXA27x	Marek Vasut <marek.vasut@gmail.com>
> Palm		Palm GSM	PXA27x		Tomas Cech <sleep_walker@suse.cz>
> Sharp		Zaurus		PXA25x/PXA27x	Many (Eric/Richard/Dmitry)
> Toshiba		E-Series	PXA25x/PXA27x	Ian Molton <spyro@f2s.com>
> 

-- 
Sincerely yours,
Mike.
