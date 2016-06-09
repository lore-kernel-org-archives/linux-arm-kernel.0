From: yinghai@kernel.org (Yinghai Lu)
Date: Wed, 8 Jun 2016 17:00:47 -0700
Subject: [PATCH v12 01/15] PCI: Let pci_mmap_page_range() take extra
 resource pointer
In-Reply-To: <CAE9FiQXPmG6UYYGHG52_i8vaBJ5yPm6Z4Zfx_BhQxVhyWC5fnw@mail.gmail.com>
References: <20160604000642.28162-1-yinghai@kernel.org>
 <20160604000642.28162-2-yinghai@kernel.org>
 <20160608210322.GA4248@localhost>
 <CAE9FiQXPmG6UYYGHG52_i8vaBJ5yPm6Z4Zfx_BhQxVhyWC5fnw@mail.gmail.com>
Message-ID: <CAE9FiQWw0pUB=1iDrX_1qyMFAUGQidSaV7CPc0aNb2CzPB-fZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2016 at 3:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:

> At the same time, can you kill __pci_mmap_set_pgprot() for powerpc.

Can you please put your two patches and this attached one into to pci/next?

Then I could send updated PCI: Let pci_mmap_page_range() take resource address.

Thanks

Yinghai
-------------- next part --------------
A non-text attachment was scrubbed...
Name: remove_powerpc_pci_prot.patch
Type: text/x-patch
Size: 2652 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/20950e15/attachment.bin>
