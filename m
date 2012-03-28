From: rientjes@google.com (David Rientjes)
Date: Wed, 28 Mar 2012 00:20:32 -0700 (PDT)
Subject: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
In-Reply-To: <1332593574.16159.31.camel@twins>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins>
Message-ID: <alpine.DEB.2.00.1203280020100.16201@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Mar 2012, Peter Zijlstra wrote:

> Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Also, why didn't lockdep catch it?
> 
> Fix sparse already instead of smearing ugly all over.
> 

Fully agreed, please don't add this to the oom killer.
