From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Oct 2016 22:07:34 +0200
Subject: [PATCH 1/5] PCI: aardvark: Name private struct pointer "advk"
 consistently
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20161007220734.5f43e444@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 07 Oct 2016 11:20:53 -0500, Bjorn Helgaas wrote:
> Use a device-specific name, "advk", for struct advk_pcie pointers to hint
> that this is device-specific information.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-aardvark.c |  370 +++++++++++++++++++--------------------
>  1 file changed, 183 insertions(+), 187 deletions(-)

For the entire series:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks for those cleanups/improvements!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
