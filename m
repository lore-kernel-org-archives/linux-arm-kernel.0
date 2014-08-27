From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 27 Aug 2014 11:44:34 -0700
Subject: [PATCH 02/10] ARM: OMAP5 / DRA7: PM: Set MPUSS-EMIF clock-domain
 static dependency
In-Reply-To: <1408716154-26101-3-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Fri, 22 Aug 2014 09:02:26 -0500")
References: <1408716154-26101-1-git-send-email-nm@ti.com>
 <1408716154-26101-3-git-send-email-nm@ti.com>
Message-ID: <7hmwapdb71.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> With EMIF clock-domain put under hardware supervised control, memory
> corruption and untraceable crashes are observed on OMAP5. Further
> investigation revealed that there is a weakness in the PRCM on this
> specific dynamic depedency.

hmm, "weakness".  That's a rather polite way of saying bug. :)

Kevin
