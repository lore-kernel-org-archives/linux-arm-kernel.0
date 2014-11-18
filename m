From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 18 Nov 2014 10:24:01 +0100
Subject: ARM: shmobile: ARCH_R8A7793?
Message-ID: <1416302641.7024.7.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Your commit 7a2071c58f36 ("ARM: shmobile: Add early debugging support
using SCIF(A)") is included in today's linux-next (ie, next-20141118).
It adds an (optional) dependency on the Kconfig symbol ARCH_R8A7793. But
that symbol isn't part of next-20141118.

Is a patch that adds this symbol queued somewhere?


Paul Bolle 
