From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 19 Sep 2014 15:03:13 -0600
Subject: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140919210313.GH19374@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 02:30:22AM +0100, Liviu Dudau wrote:
> Add of_pci_get_domain_nr() to retrieve the PCI domain number
> of a given device from DT. If the information is not present,
> the function can be requested to allocate a new domain number.

Is of_pci_get_domain_nr() used somewhere?  If the use is in some future
series, please mention it explicitly.  I'm just trying to avoid merging
unused code.

Bjorn
