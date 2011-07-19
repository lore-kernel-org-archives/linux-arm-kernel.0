From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 11:55:32 +0100
Subject: [PATCH] davinci: fix DM365 EVM video input mux bits
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DBDC68A@dbde02.ent.ti.com>
References: <1311046211-2849-1-git-send-email-jon.povey@racelogic.co.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024DBDC68A@dbde02.ent.ti.com>
Message-ID: <20110719105532.GF26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 02:26:50PM +0530, Nori, Sekhar wrote:
> Since this part of the code hasn't changed since it
> was written, this is a good candidate for stable
> kernel series. You can just add:
> 
> Cc: stable at kernel.org

Be careful when doing that - if you have git mail the patches out for
review, and it picks that up, it'll send it to the stable team as well.
The stable team will then complain "that's not how to submit patches
to them".

So, while you can add "Cc: stable at kernel.org" to the patch, its best
to only add that just before you publish the commit after review, but
before merging.
