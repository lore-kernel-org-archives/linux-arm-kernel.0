From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Jan 2012 15:12:50 -0800
Subject: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
In-Reply-To: <87obucxyif.fsf@ti.com>
References: <20120109131412.6238edf3@notabene.brown> <87obucxyif.fsf@ti.com>
Message-ID: <4F0B7472.3000108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2012 03:11 PM, Kevin Hilman wrote:
> NeilBrown<neilb@suse.de>  writes:
>
>> opp_find_freq_ceil and opp_get_voltage are documented as requiring
>> rcu_lock to be held.  So hold it.
>>
>> Signed-off-by: NeilBrown<neilb@suse.de>
>
> Missing 'ARM: ' prefix, but I added it locally and queued as a fix for
> v3.3.

oops, sent this before I saw your updated version.

Kevin
