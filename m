From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 8 Feb 2017 15:55:08 -0600
Subject: [PATCH 0/2] PCI: iproc: MPS fix and quirks
In-Reply-To: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
References: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170208215508.GA4800@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 04:44:07PM -0500, Jon Mason wrote:
> A patch that corrects an issue where the MPS could not be set, and
> another that fixes some quirks in the PAXC
> 
> Jon Mason (2):
>   PCI: iproc: allow the MPS to be set
>   PCI: Add quirk entry for NS2 PAXC PCI
> 
>  drivers/pci/host/pcie-iproc.c |  5 ++++-
>  drivers/pci/quirks.c          | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)

Applied with Ray's ack to pci/host-iproc for v4.11, thanks!

It looks to me like several other drivers need a similar MPS fix.
I'll CC you on the patches.

Bjorn
