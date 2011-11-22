From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 15:24:31 +0000
Subject: [01: PATCH 0/7] Preparation for arch_reset changes
In-Reply-To: <20111122112134.GH20518@mudshark.cambridge.arm.com>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111121095658.GO9581@n2100.arm.linux.org.uk>
 <20111122112134.GH20518@mudshark.cambridge.arm.com>
Message-ID: <20111122152431.GY9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:21:34AM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Mon, Nov 21, 2011 at 09:56:58AM +0000, Russell King - ARM Linux wrote:
> > As of today, I'm going to start freezing the restart changes, which
> > covers those which have been in linux-next so far.  I've collected up
> > all the acks, etc, to date, and will not be applying any more to these
> > commits.
> > 
> > At the end of today, I'll merge these into my 'devel-stable' branch
> > to signify their new status, so if anyone has any objections they need
> > to speak up _now_.
> 
> Is your reset branch stable now? I only ask because it doesn't look like
> you've merged these into devel-stable so I wondered if you have any further
> changes pending.

See the message I sent to Marc about his irqchip consolidation - I was
waiting for Marc to confirm that the resolution was good before I push
the stuff over to the devel-stable branch.  Marc has confirmed that
shortly after your message, so we're all good for this evening.
