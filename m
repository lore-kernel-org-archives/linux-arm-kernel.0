From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 09:42:36 +0200
Subject: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20140925074235.GN12423@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:14:10AM +0800, Yijing Wang wrote:
> This series is based Bjorn's pci/msi branch
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
> 
> Currently, there are a lot of weak arch functions in MSI code.
> Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
> This series use MSI chip framework to refactor MSI code across all platforms
> to eliminate weak arch functions. Then all MSI irqs will be managed in a 
> unified framework. Because this series changed a lot of ARCH MSI code,
> so tests in the platforms which MSI code modified are warmly welcomed!

Apart from the comments to the individual patches I very much like where
this is going. Thanks for taking care of this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/c9069230/attachment.sig>
