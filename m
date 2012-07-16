From: attila@kinali.ch (Attila Kinali)
Date: Mon, 16 Jul 2012 14:07:20 +0200
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <5003AD52.7070304@bluegiga.com>
References: <4FFC367A.8020100@bluegiga.com>
 <20120711060607.GE14060@S2101-09.ap.freescale.net>
 <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
 <5003AD52.7070304@bluegiga.com>
Message-ID: <20120716140720.4af66a1b45375bc6b83dc986@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moin, Lauri,

On Mon, 16 Jul 2012 08:57:38 +0300
Lauri Hintsala <lauri.hintsala@bluegiga.com> wrote:

> 
> 
> Does this patch fix your issue?

A preliminary test shows that it at least fixes the oops at module loading.
I haven't had the chance yet to give it a full test, but i would say it
fixes it enough to be workable.

Thanks a lot!

			Attila Kinali



-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
