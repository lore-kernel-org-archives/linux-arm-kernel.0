From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 Jun 2013 15:02:22 +0200
Subject: [PATCH v2] arch/*/asm/include/bitops.h: api issue, find_*_bit()
 defination are different with each other
In-Reply-To: <51AF225A.5020703@asianux.com>
References: <51AE8FEF.1020809@asianux.com> <51AE903C.6010806@asianux.com>
 <51AE909D.9080006@asianux.com>
 <20130605071915.GK23140@pengutronix.de>
 <51AF225A.5020703@asianux.com>
Message-ID: <20130605130222.GL23140@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 05, 2013 at 07:34:50PM +0800, Chen Gang wrote:
> >> +extern unsigned long  _find_first_zero_bit_le(const void *p,
> > doesn't checkpatch critizise the double space in the line above?
> > 
> 
> Thank you very much for your carefully checking (could you tell me how
> do you find it ?)  :-)
I have no tool for that, it just catched my eye.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
