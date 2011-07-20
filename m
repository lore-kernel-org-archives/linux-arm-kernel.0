From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jul 2011 17:48:07 +0100
Subject: [PATCH] davinci: fix DM365 EVM video input mux bits
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DC70E2A@dbde02.ent.ti.com>
References: <1311046211-2849-1-git-send-email-jon.povey@racelogic.co.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024DBDC68A@dbde02.ent.ti.com>
	<20110719105532.GF26574@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024DC70E2A@dbde02.ent.ti.com>
Message-ID: <20110720164807.GA20310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 10:10:57PM +0530, Nori, Sekhar wrote:
> Hi Russell,
> 
> On Tue, Jul 19, 2011 at 16:25:32, Russell King - ARM Linux wrote:
> > On Tue, Jul 19, 2011 at 02:26:50PM +0530, Nori, Sekhar wrote:
> > > Since this part of the code hasn't changed since it
> > > was written, this is a good candidate for stable
> > > kernel series. You can just add:
> > > 
> > > Cc: stable at kernel.org
> > 
> > Be careful when doing that - if you have git mail the patches out for
> > review, and it picks that up, it'll send it to the stable team as well.
> > The stable team will then complain "that's not how to submit patches
> > to them".
> > 
> > So, while you can add "Cc: stable at kernel.org" to the patch, its best
> > to only add that just before you publish the commit after review, but
> > before merging.
> 
> But its very tough to guess what the last version
> ready for merging will be. Review comments can come
> at any stage.
> 
> Would adding "Cc: stable at kernel.org" to the commit text
> but taking care to not actually send mail to stable at kernel.org
> help? The stable_kernel_rules.txt document seems to suggest
> this is an acceptable way:

Correct.
