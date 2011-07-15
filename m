From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Jul 2011 17:49:31 +0200
Subject: [PATCH 2/7] at91/i2c: move register header to drivers
In-Reply-To: <20110715092314.215043d5@endymion.delvare>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-2-git-send-email-plagnioj@jcrosoft.com>
	<20110715092314.215043d5@endymion.delvare>
Message-ID: <20110715154931.GB20678@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:23 Fri 15 Jul     , Jean Delvare wrote:
> Hi Jean-Christophe,
> 
> On Fri, 15 Jul 2011 01:52:00 +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: linux-i2c at vger.kernel.org
> > ---
> >  drivers/i2c/busses/i2c-at91.c                      |    3 ++-
> >  .../at91_twi.h => drivers/i2c/busses/i2c-at91.h    |    7 +++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >  rename arch/arm/mach-at91/include/mach/at91_twi.h => drivers/i2c/busses/i2c-at91.h (97%)
> 
> Why don't you just merge i2c-at91.h into i2c-at91.c then, if it's the
> only user?
I prefer to keep the define in a seperate file

Best Regards,
J.
