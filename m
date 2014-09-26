From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Sep 2014 11:05:38 +0200
Subject: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
In-Reply-To: <20140926085430.GG31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
 <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo>
Message-ID: <20140926090537.GH31106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
[...]
> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
> directly (patch attached).

Really attached this time.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-PCI-tegra-Remove-.add_bus-callback.patch
Type: text/x-diff
Size: 1887 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/f14452d9/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/f14452d9/attachment.sig>
