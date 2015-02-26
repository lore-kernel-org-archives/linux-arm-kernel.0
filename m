From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 25 Feb 2015 23:51:23 -0600
Subject: [PATCH v3 00/30] Refine PCI scan interfaces and make generic pci
 host bridge
In-Reply-To: <1424914187-21027-1-git-send-email-wangyijing@huawei.com>
References: <1424914187-21027-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20150226055123.GA5415@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 09:29:17AM +0800, Yijing Wang wrote:
> v2->v3:
> 	Rebase this series on v4.0-rc1.

Hm, still doesn't apply for me:

  11:48:15 ~/linux (pci/enumeration)$ git show --oneline | head -1
  c517d838eb7d Linux 4.0-rc1
  11:48:36 ~/linux (pci/enumeration)$ stg import -M --sign m/yw
  Checking for changes in the working directory ... done
  Importing patch "pci-rip-out" ... done
  Importing patch "pci-rip-out-0" ... done
  Importing patch "xen-pci-don-t-use-deprecated" ... done
  Importing patch "pci-remove-deprecated" ... done
  Importing patch "pci-rename-pci_scan_bus-to" ... done
  Importing patch "pci-combine-pci-domain-and-bus" ... done
  Importing patch "pci-pass-pci-domain-number" ... done
  Importing patch "pci-introduce" ... done
  Importing patch "pci-separate-pci_host_bridge" ... done
  Importing patch "pci-introduce-0" ... done
  Importing patch "pci-save-sysdata-in" ... error: patch failed: drivers/pci/host-bridge.c:58
  error: drivers/pci/host-bridge.c: patch does not apply
  error: patch failed: drivers/pci/probe.c:1954
  error: drivers/pci/probe.c: patch does not apply
  stg import: Diff does not apply cleanly
  11:48:52 ~/linux (pci/enumeration)$ 
