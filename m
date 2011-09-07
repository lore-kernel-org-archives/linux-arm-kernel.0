From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Sep 2011 12:47:40 +0100
Subject: [PATCH 3.1-rc1] ARM: entry: fix wrong parameter used in
	do_thumb_abort
In-Reply-To: <201109071310.09266.jkrzyszt@tis.icnet.pl>
References: <201108241307.21056.jkrzyszt@tis.icnet.pl>
	<201109071310.09266.jkrzyszt@tis.icnet.pl>
Message-ID: <20110907114740.GS6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 01:10:08PM +0200, Janusz Krzysztofik wrote:
> Any plans to fix this regression before the rc cycle is over, or at 
> least explain why it won't be fixed?

Apart from the patch being buried beneath a ton of email, and then
being shuffled off into my "August 2011" mailbox which doesn't get
looked at... no.

> Any special requirements as to the process of submitting bug fixes 
> against arch/arm common bits?

It needs to go into the patch system for merging so that it doesn't
get buried and forgotten - as already demonstrated.
