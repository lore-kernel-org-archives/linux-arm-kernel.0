From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 12 Apr 2016 17:44:13 +0100
Subject: [PATCH v2 2/4] PCI: Provide common functions for ECAM mapping
In-Reply-To: <570C78F1.4090701@jonmasters.org>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
 <570C4034.20105@caviumnetworks.com>
 <570C78F1.4090701@jonmasters.org>
Message-ID: <20160412164413.GA32297@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 12:26:25AM -0400, Jon Masters wrote:

[...]

> Quoting Bjorn's original reply to the previous series:
> 
> > Some of the code that moved to drivers/acpi/pci_mcfg.c is not
> > really ACPI-specific, and could potentially be used for non-ACPI
> > bridges that support ECAM.  I'd like to see that sort of code
> > moved to a new file like drivers/pci/ecam.c.
> 
> So my guess is that this is the reasoning behind JC's file layout.
> 
> I'm curious what Lorenzo's take on things is currently. I assume this
> series is now to be the official coordinated version of this effort for
> upstream, following the advice of Bjorn previously, but I would like to
> know if everyone is behind this plan. I've (previously) requested a
> Linaro LEG meeting this week (part of our bootarch working group) to
> specifically discuss the status of PCI upstreaming in order to get the
> different vendors together to ensure every single one of them is
> tracking the correct latest effort and doing what is needed to test/aid,
> hence my ask. If this is now plan A, I'll make sure everyone is aligned
> behind it and start pinging people individually for testing.

My take is that JC's aim is to get this four patch series reviewed and
merged (which is *not* sufficient to get ACPI PCI to work fully on ARM64
- see cover letter - the remaining patches in his branch are not
fixes, it is code that is required to get things to work, these 4
patches stand alone are not sufficient but I understand he wants to get
them reviewed following feedback on the lists) so that we can make
progress on ACPI PCI on ARM64.

I will comment on the patches as soon as I have time to review
them, I certainly would like to understand what we have to do with the
rest of the code though (provided this series is good to go) see above.

Lorenzo
