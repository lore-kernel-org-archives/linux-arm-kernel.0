From: eparis@redhat.com (Eric Paris)
Date: Wed, 15 Feb 2012 10:10:58 -0500
Subject: [PATCH] ARM: ptrace: Include linux/audit.h to fix build errors
In-Reply-To: <20120215101832.GF13673@n2100.arm.linux.org.uk>
References: <1329284188.12708.1.camel@phoenix>
 <20120215083609.GD13673@n2100.arm.linux.org.uk>
 <20120215095216.GA29319@mudshark.cambridge.arm.com>
 <20120215101832.GF13673@n2100.arm.linux.org.uk>
Message-ID: <1329318658.2337.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-15 at 10:18 +0000, Russell King - ARM Linux wrote:

> So, this gives us two options: either we revert the damned thing and start
> over with it (and hopefully audit folk will start co-operating with ARM
> folk) or we try to fix up their mess (and potentially they learn they can
> dump crap on us.)

It must be a conspiracy to screw with the ARM people!  Your jobs were
obviously too easy to begin with.  Rahrrrrr!  Down with ARM!

No seriously.  I am the audit folks.  You got us all right here in this
one e-mail.  You're right, I should have paid more attention to who was
in the cc list.  If you want to rewrite it, please feel free!  If you
want to push fixes yourself, please feel free!  If you want me to push
fixes, please just let me know what is broken and I'll do my best.

Sorry.  I just got the patch and was contacted by a number of people off
list asking when it was going to go in because they wanted it for their
project.  I obviously should have known who the ARM maintainers that
would have looked at a patch for the audit system was and should have
made sure they commented.  Sorry!  I'll be sure to hit the ARM list if
another patch goes by....
