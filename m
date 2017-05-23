From: slash.tmp@free.fr (Mason)
Date: Tue, 23 May 2017 20:07:53 +0200
Subject: [PATCH v4 0/2] Tango PCIe controller support
In-Reply-To: <20170523171758.GC24431@bhelgaas-glaptop.roam.corp.google.com>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <20170523171758.GC24431@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <cb5d08d6-bbbe-486f-b721-2eeeb410ab5e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/2017 19:17, Bjorn Helgaas wrote:
>
> On Thu, Apr 20, 2017 at 04:24:39PM +0200, Marc Gonzalez wrote:
>
>> This patch was split in two, to ease review of two orthogonal
>> parts (MSI controller and host bridge). NB: the patch is
>> just split in two where host bridge support starts.
> 
> The split is backwards.  The first patch should add basic host bridge
> support that is functional, though lacking MSI support.  The second should
> add the MSI support.

OK, I'll invert the patches.

Note: the bridge does not support legacy interrupts.
Without MSI support, EPs can't interrupt the host.
Is that still considered functional?

Regards.
