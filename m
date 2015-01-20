From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Jan 2015 12:50:59 -0200
Subject: [next-20150119]regression (mm)?
In-Reply-To: <20150120140546.DDCB8D4@black.fi.intel.com>
References: <54BD33DC.40200@ti.com> <20150119174317.GK20386@saruman>
 <20150120001643.7D15AA8@black.fi.intel.com>
 <20150120114555.GA11502@n2100.arm.linux.org.uk>
 <20150120140546.DDCB8D4@black.fi.intel.com>
Message-ID: <CAOMZO5D-Z-FLPmQ4Yy3rxBa-FebLcnG9TSzg3F-MF-TFBBMrwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 12:05 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> Russell King - ARM Linux wrote:
>> On Tue, Jan 20, 2015 at 02:16:43AM +0200, Kirill A. Shutemov wrote:
>> > Better option would be converting 2-lvl ARM configuration to
>> > <asm-generic/pgtable-nopmd.h>, but I'm not sure if it's possible.
>>
>> Well, IMHO the folded approach in asm-generic was done the wrong way
>> which barred ARM from ever using it.
>
> Okay, I see.
>
> Regarding the topic bug. Completely untested patch is below. Could anybody
> check if it helps?

Yes, it helps. Now I can boot mx6 running linux-next 20150120 with
your patch applied.
