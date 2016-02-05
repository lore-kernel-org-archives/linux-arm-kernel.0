From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 06 Feb 2016 00:26:37 +0100
Subject: [PATCH v7 5/5] PCI: ACPI: Add a generic ACPI based host controller
In-Reply-To: <20160205094740.GA31547@red-moon>
References: <1454058340-7904-1-git-send-email-jchandra@broadcom.com>
 <CAKc_7PXYtFt1MQE-UGO0O5vvQ+xFKa2b5=F8wXB=EN-JUJVzZw@mail.gmail.com>
 <20160205094740.GA31547@red-moon>
Message-ID: <3576289.1ltj0IceQ5@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 05, 2016 09:47:40 AM Lorenzo Pieralisi wrote:
> On Fri, Feb 05, 2016 at 02:05:37PM +0530, Jayachandran Chandrashekaran Nair wrote:
> 
> [...]
> 
> > pci_host_acpi.c is a generic implementation of these using a sysdata
> > pointing to acpi_pci_root_info, and using a pointer to the pci_mmcfg_region
> > to access ECAM area, Maybe I can rename this file to
> > pci_acpi_host_generic.c to reflect this better.
> 
> Maybe you should stop sending this series and work with Tomasz to
> get this done, you are confusing everyone and I am really really
> annoyed about this.
> 
> Do you realize there is no point in having two patch series doing
> the same thing and wasting everyone's review time ?
> 
> Do you realize he started this work long before you and went through
> several rounds of review already (I told you before but in case you
> forgot) ?
> 
> Tomasz posted a version yesterday, integrating comments following months
> of review and testing and I think it is ready to get upstream:
> 
> https://lkml.org/lkml/2016/2/4/646
> 
> Did you even consider reviewing his code or helping him instead of
> churning out more patches doing the *SAME* thing ?
> 
> Do you want all of us to go through your code and re-fix what has
> already been fixed in Tomasz's series with the end result of missing
> yet another merge window ?
> 
> This is really annoying, stop it please, really.

OK, so to be crystal clear here.

I'm going to ignore the series the $subject patch belongs to going forward.

Thanks,
Rafael
