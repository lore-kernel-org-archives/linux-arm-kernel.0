From: ray.jui@broadcom.com (Ray Jui)
Date: Fri, 27 Jan 2017 13:46:56 -0800
Subject: [PATCH 0/2] PCI: iproc: MPS fix and quirks
In-Reply-To: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
References: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <55c4e250-1317-0ddb-33f8-914f966f6c99@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The entire patch set looks good to me. Thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>

On 1/27/2017 1:44 PM, Jon Mason wrote:
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
> 
