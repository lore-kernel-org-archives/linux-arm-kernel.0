From: giometti@enneenne.com (Rodolfo Giometti)
Date: Mon, 30 Dec 2013 19:39:08 +0100
Subject: Can't boot newer kernel on Armada 370 dev board
In-Reply-To: <20131230181205.GA32362@lunn.ch>
References: <20131230174738.GA4172@enneenne.com>
 <20131230181205.GA32362@lunn.ch>
Message-ID: <20131230183908.GB4172@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 07:12:05PM +0100, Andrew Lunn wrote:
>
> Hi Redolfo
> 
> What version of u-boot do you have?

U-Boot 2011.12 (Dec 24 2013 - 16:16:38) Marvell version: v2011.12 2013_Q3.0

> There has been a change in u-boot
> so that the registers are mapped to a different address. Old u-boot
> with new kernel causes instant lockup on boot as soon as it tries to
> access the wrong address space.

I see. Where can I get newer u-boot releases in order to avoid this
problem? :-)

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
