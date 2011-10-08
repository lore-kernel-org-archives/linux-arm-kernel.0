From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Oct 2011 10:10:36 +0100
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
In-Reply-To: <4E8F028C.10102@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
	<4E8F028C.10102@stericsson.com>
Message-ID: <20111008091036.GF25689@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 03:45:48PM +0200, Ulf Hansson wrote:
> My feeling is that since discussing this patch, the rest of the patches  
> in this serie and are kind of "put on hold". The reason for keeping them  
> together is more of functional purpose. I hope you can have a look at  
> them anyway, they shall be possible to apply without this one.

Well, the patch system says that each one depends on the previous one,
and the first one in the series contains the PIO read thing.

Do 7108/1 onwards depend on 7106/1 and 7107/1 ?
