From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Aug 2013 12:43:09 +0100
Subject: [PATCH v6 0/5] ARM/ARM64 architected timer updates
In-Reply-To: <52206EE0.5020907@arm.com>
References: <1377788142-21388-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <52206EE0.5020907@arm.com>
Message-ID: <20130830114309.GW6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 11:07:28AM +0100, Sudeep KarkadaNagesha wrote:
> On 29/08/13 15:55, Sudeep KarkadaNagesha wrote:
> > From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> > 
> > This patch series adds support to configure the rate and enable the
> > event stream for architected timer. The event streams can be used to
> > impose a timeout on a wfe, to safeguard against any programming error
> > in case an expected event is not generated or even to implement
> > wfe-based timeouts for userspace locking implementations. This feature
> > can be disabled(enabled by default).
> > 
> > Since the timer control register is reset to zero on warm boot, CPU
> > PM notifier is added to save and restore the value.
> > 
> Hi Russell,
> 
> Can you have a look at this series ?
> If you are OK, can I have your ACK on arm specific changes(PATCH 2/5) ?

I think it would be more value to have someone from ARM Ltd ack it,
because they will know the code much better than I do.
