From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 27 Jun 2014 08:55:04 -0600
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140627141451.GJ15296@arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <20140405001953.GE15806@google.com>
 <20140407083120.GE17163@e106497-lin.cambridge.arm.com>
 <5183143.FxBNM0xTAV@wuerfel>
 <CAErSpo4iEV6khP63ZTF+YUTKi9WLFXzMv13nxw15y3qDg15Ztg@mail.gmail.com>
 <20140626085926.GB11244@arm.com>
 <CAL_JsqKCHf6VXR3FFcBSu1xuhP54dYsAJCZwT-X9p5iTZAOJfQ@mail.gmail.com>
 <20140627141451.GJ15296@arm.com>
Message-ID: <CAErSpo7nhqJGXcnY4FO=6CZtYdSY0qNUyRSP3nnxAUO5L6c+jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 8:14 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> ...
> With Liviu's latest version (not posted) and with
> of_create_pci_host_bridge() function moved to of_pci.c, I don't think
> there is much new functionality added to drivers/pci/. What I think we
> need is clarifying the domain_nr patch (and API change) and more users
> of the new generic code. As you said, it doesn't need to be a separate
> architecture but rather existing pci host drivers under drivers/pci. Of
> course, other arch conversion should follow shortly as well but even
> without an immediate conversion, I don't see too much additional
> maintenance burden for the core PCIe code (and code sharing between new
> PCIe host drivers is even more beneficial).

Sorry, I haven't had time to follow this.  It sounds like there are
several pieces we could get out of the way easily.  How about posting
the actual patches again?  Maybe re-order them so the easy pieces are
first so they can get applied even if there are issues with later
ones?

Bjorn
