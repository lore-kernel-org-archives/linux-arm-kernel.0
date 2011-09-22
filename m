From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 12:45:32 -0700
Subject: [RFC PATCH V6 0/4] cpuidle: Global registration of idle states
	with per-cpu statistics
In-Reply-To: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
	(Deepthi Dharwar's message of "Thu, 22 Sep 2011 13:58:52 +0530")
References: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Message-ID: <87ty84tl7n.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deepthi Dharwar <deepthi@linux.vnet.ibm.com> writes:

> The following patch series implements global registration of cpuidle
> states, and also has the necessary data structure changes to
> accommodate the per-cpu writable members of the cpuidle_states
> structure.

I reviewed earlier versions of the series, and this version still looks
good to me.  Any reason it is still RFC?

Reviewed-by: Kevin Hilman <khilman@ti.com>

and for the OMAP-specific parts,

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin
