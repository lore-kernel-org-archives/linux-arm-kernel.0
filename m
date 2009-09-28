From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 19:17:42 +0100
Subject: [PATCH] Move MMCI header to amba include dir
In-Reply-To: <9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
References: <1253625972-19407-1-git-send-email-linus.walleij@stericsson.com>
	<9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <20090928181742.GH10671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 10:11:29AM -0700, Scott Branden wrote:
> Hi Linus,
> 
> You changes cause the bcmring platform to fail to compile.
> 
> Can you go through all the ARM platforms and make the
> necessary adjustments with the change in header files
> for mmc?

Since Linus's change has been merged, and it's a conflict caused by
simultaneous development, you _both_ need to work towards sorting it
out.

Please put some time into looking at the changes and doing whatever's
necessary to sort bcmring out.  It's quite a simple change at the
end of the day - a move of a header file and a rename of a structure.
