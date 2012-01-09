From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Jan 2012 15:11:04 -0800
Subject: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
In-Reply-To: <20120109131412.6238edf3@notabene.brown> (NeilBrown's message of
 "Mon, 9 Jan 2012 13:14:12 +1100")
References: <20120109131412.6238edf3@notabene.brown>
Message-ID: <87obucxyif.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NeilBrown <neilb@suse.de> writes:

> opp_find_freq_ceil and opp_get_voltage are documented as requiring
> rcu_lock to be held.  So hold it.
>
> Signed-off-by: NeilBrown <neilb@suse.de>

Missing 'ARM: ' prefix, but I added it locally and queued as a fix for
v3.3.

Thanks for the patch!

Kevin
