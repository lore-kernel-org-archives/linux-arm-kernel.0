From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 31 Jul 2012 09:45:37 +0100
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <20120731082742.GU18016@lunn.ch>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 <87obmw5rm9.fsf@lebrac.rtp-net.org> <50179528.2020801@codethink.co.uk>
 <20120731082742.GU18016@lunn.ch>
Message-ID: <50179B31.1000202@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 09:27, Andrew Lunn wrote:
> On Tue, Jul 31, 2012 at 09:19:52AM +0100, Ian Molton wrote:
>> Are you sure this is required? It can always be added if anything
>> actually uses it :)
> Hi Ian
>
> Try using jumbo packets on kirkwood.
>
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/178785
> http://www.spinics.net/lists/arm-kernel/msg186152.html

Ah, this postdates the D-T branches on which I am working being forked.

I'll fold this into my patchset.

-Ian
