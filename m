From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 8 Oct 2014 10:13:21 +0100
Subject: [PATCH v13 00/12] Support for creating generic PCI host bridges
 from DT
In-Reply-To: <20141008074428.GD20256@rric.localhost>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
 <20140929194335.GA13747@google.com>
 <20140930103942.GO841@e106497-lin.cambridge.arm.com>
 <20140930161805.GB5625@google.com>
 <20140930165431.GV841@e106497-lin.cambridge.arm.com>
 <20141008074428.GD20256@rric.localhost>
Message-ID: <20141008091321.GC4652@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 08:44:28AM +0100, Robert Richter wrote:
> Liviu, Bjorn,
> 
> On 30.09.14 17:54:31, Liviu Dudau wrote:
> > On Tue, Sep 30, 2014 at 05:18:05PM +0100, Bjorn Helgaas wrote:
> > > OK, I rebuilt pci/host-generic from scratch.  It consists of your v13
> > > patches + Arnd's build fix for pci_pio_to_address() in !CONFIG_OF configs.
> > 
> > Something went wrong with the integration, patch 02 adds another definition of 
> > of_pci_range_to_resource() before it is moved out of the header file for some reason.
> 
> I assume pci/host-generic is the latest now with this issue fixed as
> the commit date is 2014-10-01 past you message above, right? So is it
> ok to rebase our host controller driver onto pci/host-generic or will
> there be further updates or any other branch that is newer?

You can rebase either on top of Bjorn's next branch or use linux-next. Hope to
see it in v3.18 soon.

Best regards,
Liviu

> 
> Thanks,
> 
> -Robert
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
