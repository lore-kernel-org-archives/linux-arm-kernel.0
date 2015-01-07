From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 Jan 2015 07:41:54 +0100
Subject: [PATCH] spi: orion: Add multiple chip select support for Armada
 370 and 375
In-Reply-To: <54AC5B16.9020206@free-electrons.com>
References: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
 <54AC5B16.9020206@free-electrons.com>
Message-ID: <20150107074154.1334b5c0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 06 Jan 2015 23:00:54 +0100, Gregory CLEMENT wrote:

> On 06/01/2015 22:30, Ken Wilson wrote:
> > Create a new dt binding for the Armada 375 that supports up to
> > 3 chip selects but uses the same prescaler values and algorithm
> > as the basic orion binding.
> 
> There was already a patch that have been sent for this:
> http://thread.gmane.org/gmane.linux.kernel.spi.devel/17808/focus=17809
> 
> but in the end it has not been merged. The last email on the thread was
> about doing the manipulation in set_cs and not in setup_transfer(). And I
> didn't find a newer version.
> 
> Maybe it just fell through the cracks.
> Thomas did you remember of it?

Yes, it is still on my TODO-list, but I haven't yet gotten around to
submitting a new version. So I haven't looked at Ken's contribution,
but if Ken is willing to bring it up to a state where it can be
mainlined, that would definitely be welcome.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
