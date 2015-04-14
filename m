From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Apr 2015 12:44:47 +0200
Subject: [PATCH 05/13] thermal: inline only once used function
In-Reply-To: <20150407022307.GE4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-6-git-send-email-s.hauer@pengutronix.de>
 <20150407022307.GE4648@localhost.localdomain>
Message-ID: <20150414104447.GI4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 07:23:08PM -0700, Eduardo Valentin wrote:
> On Thu, Mar 26, 2015 at 04:53:52PM +0100, Sascha Hauer wrote:
> > Inline update_temperature into its only caller to make the code
> > more readable.
> 
> I am not sure I understand how this is improving readability, can you
> please elaborate?

It improves readability because the reader does not have to lookup the
definition of update_temperature but can instead just read through. The
function name "update_temperature" does not give new information either,
so I thought inlining the code is a good idea. Anyway, I can skip this
patch if you want.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
