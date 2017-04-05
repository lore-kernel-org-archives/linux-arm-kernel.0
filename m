From: dev.srinivasulu@gmail.com (Thanneeru Srinivasulu)
Date: Wed, 5 Apr 2017 12:07:24 +0530
Subject: [PATCH] net: thunderx: Switch to pci_alloc_irq_vectors
In-Reply-To: <20170405062740.GB26470@lst.de>
References: <1491298146-13609-1-git-send-email-tsrinivasulu@cavium.com>
 <20170405062740.GB26470@lst.de>
Message-ID: <CAMtOeK+nuY0KVbNutPgR9mpkfqpWB3g75evAQNECvG8OxRfGNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 11:57 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Apr 04, 2017 at 02:59:06PM +0530, dev.srinivasulu at gmail.com wrote:
>> From: Thanneeru Srinivasulu <tsrinivasulu@cavium.com>
>>
>> Remove deprecated pci_enable_msix API in favour of it's
>> successor pci_alloc_irq_vectors.
>>
>> Signed-off-by: Thanneeru Srinivasulu <tsrinivasulu@cavium.com>
>> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
>
> Looks good.
>
> Are you fine with me queueing this up together with the other
> pci_enable_msix() removal patches?

No issues, thanks.
