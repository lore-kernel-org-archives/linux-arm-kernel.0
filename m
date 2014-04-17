From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 17 Apr 2014 09:09:36 +0200
Subject: [PATCH v2 2/4] ARM: mvebu: fix NOR bus-width in Armada XP GP
 Device Tree
In-Reply-To: <20140417050832.GP28159@titan.lakedaemon.net>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397489361-5833-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140417050832.GP28159@titan.lakedaemon.net>
Message-ID: <20140417090936.387c79c6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 17 Apr 2014 01:08:32 -0400, Jason Cooper wrote:

> Patches 2, 3, and 4 applied to mvebu/dt-fixes for stable with Gregory
> and Ezequiel's Acks.

Thanks.

> Also, a gentle nit:  You're doing all the -stable info digging, would
> you mind putting it in the following format so I don't have to hand edit
> each patch?

Sure! So far I've just been blindly following
Documentation/stable_kernel_rules.txt, and besides the "Cc:
stable at vger.kernel.org" it doesn't say anything else of what you're
suggesting below.

> ------
> Link: ...

What should this link point to?

> Fixes: da8d1b383568 ('ARM: mvebu: Add support for NOR flash device on Armada XP-GP board')

Ok. But this is not described in Documentation/stable_kernel_rules.txt.

> Cc: stable at vger.kernel.org # v3.10+

The Cc: to stable@ is documented, but the use of a comment with the
kernel version afterwards is only mentioned when the commit in question
requires other commits as dependencies to be applied to stable. When
the commit is self-sufficient, stable_kernel_rules.txt doesn't indicate
that a comment is needed.

Maybe an update to stable_kernel_rules.txt is in order? :-)

Thanks again!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
