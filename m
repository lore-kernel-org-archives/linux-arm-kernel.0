From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 15:32:49 +0200
Subject: [PATCH] sata/mvebu: use #ifdef around suspend/resume code
In-Reply-To: <20151012152703.4d82bd02@free-electrons.com>
References: <5727002.l6plqmRKB3@wuerfel>
 <20151012152703.4d82bd02@free-electrons.com>
Message-ID: <12835033.bJyOonOTBZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 15:27:03 Thomas Petazzoni wrote:
> Arnd,
> 
> On Mon, 12 Oct 2015 15:05:27 +0200, Arnd Bergmann wrote:
> 
> > +#ifdef CONFIG_PM_SUSPEND
> 
> Shouldn't this be CONFIG_PM_SLEEP ?
> 
> The generic suspend/resume function in libahci_platform.c are defined
> when CONFIG_PM_SLEEP is enabled.
> 

Right, I'll send a fixed version, please ignore this one!

	Arnd
