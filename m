From: panand@redhat.com (Pratyush Anand)
Date: Thu, 8 Oct 2015 22:21:18 +0530
Subject: [PATCH v4 1/2] arm64: Introduce IRQ stack
In-Reply-To: <66863807-964F-41D1-9788-D0FD8E79ADB6@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-2-git-send-email-jungseoklee85@gmail.com>
 <20151008102520.GA10912@dhcppc13.redhat.com>
 <66863807-964F-41D1-9788-D0FD8E79ADB6@gmail.com>
Message-ID: <20151008165118.GC10912@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jungseok,

On 08/10/2015:11:32:43 PM, Jungseok Lee wrote:
> On Oct 8, 2015, at 7:25 PM, Pratyush Anand wrote:
> > Hi Jungseok,
> 
> Hi Pratyush,
> 
> > 
> > On 07/10/2015:03:28:11 PM, Jungseok Lee wrote:
> >> Currently, kernel context and interrupts are handled using a single
> >> kernel stack navigated by sp_el1. This forces a system to use 16KB
> >> stack, not 8KB one. This restriction makes low memory platforms suffer
> >> from memory pressure accompanied by performance degradation.
> > 
> > How will it behave on 64K Page system? There, it would take atleast 64K per cpu,
> > right?
> 
> It would take 16KB per cpu even on 64KB page system.
> The following code snippet from kernel/fork.c would be helpful.

Yes..Yes..its understood.
Thanks for pointing to the code.

~Pratyush
