From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 Nov 2011 09:36:48 -0800
Subject: [PATCH] arm: cpuidle34xx.c: Fix compile error
In-Reply-To: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com> (Joerg
 Roedel's message of "Tue, 8 Nov 2011 17:11:05 +0100")
References: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com>
Message-ID: <87hb2eqzwv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joerg Roedel <joerg.roedel@amd.com> writes:

> Add missing module.h include to provide THIS_MODULE.
>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

FYI...

Tony has already queued fix for this in his fixes branch.

     http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

Kevin
