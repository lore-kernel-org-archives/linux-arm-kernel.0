From: dv@vollmann.ch (Detlef Vollmann)
Date: Mon, 21 Mar 2011 23:41:50 +0100
Subject: Updated mach-types update
In-Reply-To: <20110320110322.GC16646@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
Message-ID: <20110321234150.23936e8f.dv@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Mar 2011 11:03:22 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> What this means is that any platform in the machine database which has not
> been submitted to mainline for 12 months since it was registered will be
> automatically dropped from the file, and the platform maintainer will need
> to either talk to me to get it reinstated before submission, or update the
> entry in some way to 'freshen' it.
So what happens to the number that was allocated for a platform that
got dropped?  Will it be recycled for another platform or is it safe
to use it in code that is not intended to go mainline (to avoid cluttering
mainline with code that doesn't need to be mainline)?

  Detlef
