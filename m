From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Nov 2015 17:40:32 +0100
Subject: [PATCH v11 2/5] missing include asm/paravirt.h in cputime.c
In-Reply-To: <1446737696-9749-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20151105164032.GG3604@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



How can this be missing? Things compile fine now, right? So please
better explain why we do this change.
