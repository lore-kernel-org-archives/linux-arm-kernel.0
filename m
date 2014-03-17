From: giometti@enneenne.com (Rodolfo Giometti)
Date: Mon, 17 Mar 2014 15:00:56 +0100
Subject: [PATCH v2 15/15] ARM: at91/dt: at91-cosino_mega2560 remove
 useless tsadcc node
In-Reply-To: <1395064628-644-16-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395064628-644-16-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140317140056.GX21643@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 02:57:08PM +0100, Alexandre Belloni wrote:
> The tsadcc node is useless as it doesn't refer to anything and the touchscreen
> is handled by the adc0 node.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Rodolfo Giometti <giometti@linux.it>

Acked.

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
