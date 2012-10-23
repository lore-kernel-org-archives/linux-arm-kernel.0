From: jonathan@jonmasters.org (Jon Masters)
Date: Tue, 23 Oct 2012 12:30:14 -0400
Subject: alignment faults in 3.6
In-Reply-To: <20121005105133.GP4625@n2100.arm.linux.org.uk>
References: <506E1762.3010601@gmail.com>
 <20121005072914.GE4625@n2100.arm.linux.org.uk>
 <20121005105133.GP4625@n2100.arm.linux.org.uk>
Message-ID: <5086C616.2030202@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2012 06:51 AM, Russell King - ARM Linux wrote:

<snip switch out the might_fault __get_user for atomic
probe_kernel_address related discussion>

> Okay, this should fix the issue...  I've only compile tested it so far.
> Rob, as you have a way to trigger this easily, can you give this patch
> a go and let me know if it solves your problem?  Thanks.

Russell, can you let me know the status of this patch? I don't see it in
your tree, and I think I might have missed a followup patch from you? It
seems to solve a real problem with in-kernel faults during the dump_mem
in general, even beyond just an alignment fault.

Jon.
