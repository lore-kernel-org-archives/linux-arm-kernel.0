From: lftan@altera.com (Ley Foon Tan)
Date: Fri, 23 Oct 2015 09:55:04 +0800
Subject: [PATCH v11 2/6] pci: add Altera PCI vendor ID
In-Reply-To: <20151022221355.GJ21237@localhost>
References: <1445506051-21688-1-git-send-email-lftan@altera.com>
 <1445506051-21688-3-git-send-email-lftan@altera.com>
 <20151022221355.GJ21237@localhost>
Message-ID: <CAFiDJ59j5KZej+PgiFVTO2ob5=w79yF=c6RAzrrWQHEi8AwOAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 6:13 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Oct 22, 2015 at 05:27:27PM +0800, Ley Foon Tan wrote:
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  include/linux/pci_ids.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index d9ba49c..08e4462 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -1550,6 +1550,8 @@
>>  #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
>>  #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
>>
>> +#define PCI_VENDOR_ID_ALTERA         0x1172
>> +
>
> This doesn't seem to be used anywhere, so I'll drop this patch.
Okay.

Thanks.

Regards
Ley Foon
