From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 31 Jul 2012 10:14:23 +0100
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <87k3xk5mti.fsf@lebrac.rtp-net.org>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 <87obmw5rm9.fsf@lebrac.rtp-net.org> <50179528.2020801@codethink.co.uk>
 <20120731082742.GU18016@lunn.ch> <50179B31.1000202@codethink.co.uk>
 <87k3xk5mti.fsf@lebrac.rtp-net.org>
Message-ID: <5017A1EF.2000307@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 09:58, Arnaud Patard (Rtp) wrote:
>> Ah, this postdates the D-T branches on which I am working being forked.
> the original patch was from years ago but I noticed only recently it was
> still not merged and sent this patch. I asked about it on DT because I
> don't want it to get lost again, even if it looks like not a lot of
> people are using jumbo frames on kirkwood or dove.

No problem :) actually it works really nicely in DT, just drop it in
the toplevel includes!

-Ian
