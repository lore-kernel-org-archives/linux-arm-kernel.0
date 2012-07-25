From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 24 Jul 2012 21:33:32 -0600
Subject: PCI mini-summit
Message-ID: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're planning a PCI mini-summit on Tuesday, August 28, in San Diego.
If you'd like an invitation, let me know.

We haven't drafted an agenda yet, but based on ideas we've heard so
far, we'll likely talk about some of the following topics:

      Host bridge hotplug
      PCI hotplug core rework
      VFIO v2 for KVM
      Dynamic resource assignment
      SRIOV
          Management: driver (module parms) vs core (sysfs?)
          Dynamic/static: changing number of VFs requires driver cooperation
      Candidates for unification/moving from arch code to the core:
          res->parent usage
          Claiming resources
          Unassigned BAR detection
          ECAM (a.k.a. MMCONFIG)
          Domain (a.k.a. PCI segment) support
          MPS config
          MPS safety with respect to hotplug

I've also heard that PCI-on-ARM may be of interest, so if you want to
talk about that and possibly add some topics, let me know.

Bjorn
