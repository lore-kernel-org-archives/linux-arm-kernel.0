From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 31 Jan 2012 12:37:33 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120131092412.GA2471@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <4F27AA98.2090602@freescale.com> <20120131092412.GA2471@pengutronix.de>
Message-ID: <201201311237.33997.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What's about to add a module_param() to enable/disable the BBT for GPMI?
> > What's your suggestion?
> 
> I'd make it board specific rather than a module parameter like most
> other drivers seem to do.
> 
> Thanks,
> 
>    Wolfram

Actually it's not board specific. You can run various bootloaders or various 
bootstrap tools on any of those boards. Though pdata seems ok for the default 
case, maybe we should have a simple way to override this?

M
