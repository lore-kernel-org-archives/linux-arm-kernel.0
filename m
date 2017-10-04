From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Wed, 4 Oct 2017 15:07:17 +0530
Subject: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
In-Reply-To: <20171004063027.GA20459@lst.de>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
 <20171001074203.GA11115@lst.de> <20171002172128.GV8463@localhost.localdomain>
 <20171004063027.GA20459@lst.de>
Message-ID: <CAKUFe6aqX5V10eszHMaD906+zhvk9iavOKSn0t0=XYM1rA9_3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yes, this patch works for our platform.

On Wed, Oct 4, 2017 at 12:00 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Oct 02, 2017 at 11:21:29AM -0600, Keith Busch wrote:
>> Yah, calling this a DMA address was a misnomer and confusing.
>
> Abhishek, can you test if this works for you?
