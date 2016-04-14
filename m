From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 14 Apr 2016 11:05:49 +0100
Subject: [PATCH v2 2/4] PCI: Provide common functions for ECAM mapping
In-Reply-To: <570F30D4.2030102@jonmasters.org>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
 <570C4034.20105@caviumnetworks.com>
 <570C78F1.4090701@jonmasters.org> <20160412164413.GA32297@red-moon>
 <570F30D4.2030102@jonmasters.org>
Message-ID: <20160414100549.GC24733@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 01:55:32AM -0400, Jon Masters wrote:

[...]

> > I will comment on the patches as soon as I have time to review
> > them, I certainly would like to understand what we have to do with the
> > rest of the code though (provided this series is good to go) see above.
> 
> Right. That's my reason for asking. I'd like to know who is driving (I
> believe that to be Lorenzo) and what the path forward is, and whether we
> need to get additional support from anyone else. There's a multi-vendor
> meeting in the morning where I'm going to summarize the current state of
> these patches and I would like to know (soon) what the plan is so that
> we can get everyone on deck to help out at least with testing (most have
> tested the previous set, but we need public acks happening).

Testing always helps, this code needs reviewing from PCI and ACPI
standpoints, what we can do is review this series and repost the whole
thing when we agree the ECAM refactoring this series is implementing
is the right way to go and it is a step in that direction, with no
generic MCFG support in the kernel ACPI PCI on ARM64 can't be
implemented so I would start from that.

Lorenzo
