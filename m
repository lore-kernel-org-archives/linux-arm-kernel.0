From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 11 Feb 2013 01:13:04 +0530
Subject: [PATCH v5 14/45] rcu,
 CPU hotplug: Fix comment referring to stop_machine()
In-Reply-To: <20130209001439.GQ2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073630.13822.99359.stgit@srivatsabhat.in.ibm.com>
 <20130209001439.GQ2666@linux.vnet.ibm.com>
Message-ID: <5117F848.1090700@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2013 05:44 AM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2013 at 01:06:34PM +0530, Srivatsa S. Bhat wrote:
>> Don't refer to stop_machine() in the CPU hotplug path, since we are going
>> to get rid of it. Also, move the comment referring to callback adoption
>> to the CPU_DEAD case, because that's where it happens now.
>>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> Ouch!  That comment is indeed obsolete and must die.
> 
> I queued this to -rcu with your Signed-off-by.  However, I omitted
> the added comment, as it is imcomplete -- it is easy to look at
> rcu_cleanup_dead_cpu() to see what it does.
>

Cool! I'll drop it from my patch series then. Thank you!

Regards,
Srivatsa S. Bhat
