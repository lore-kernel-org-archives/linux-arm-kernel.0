From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 06 Aug 2015 08:56:18 +0100
Subject: [PATCH 1/3] Docs: dt: add generic MSI bindings
In-Reply-To: <20150805165120.GB28849@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-2-git-send-email-mark.rutland@arm.com>
 <20150805165120.GB28849@leverpostej>
Message-ID: <55C31322.1000608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/15 17:51, Mark Rutland wrote:
> Rob,
> 
> Do you have any objections to this, or are you happy to take this patch?
> 
> There's a user of this binding (the GICv3 ITS) queued for v4.3 already in
> the tip tree, so either we either need to be ok with this binding or we
> need to rework that before v4.3.
> 
> Marc, can I take it from your use of the binding that you are happy to
> provide your ack?

Definitely.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
