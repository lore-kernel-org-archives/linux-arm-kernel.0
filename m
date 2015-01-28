From: dhowells@redhat.com (David Howells)
Date: Wed, 28 Jan 2015 16:42:27 +0000
Subject: [PATCH] MPILIB: avoid assembler warning
In-Reply-To: <16372019.BFlLRod3Eu@wuerfel>
References: <16372019.BFlLRod3Eu@wuerfel>
Message-ID: <9572.1422463347@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> wrote:

> Not sure who would be the best person to pick this patch up.

I can pick it up, but I wonder if the MPI asm bits should be distributed to
asm/mpilib.h headers rather than being in the lib/ directory.

David
