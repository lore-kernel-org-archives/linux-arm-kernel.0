From: tinamdar@apm.com (Tanmay Inamdar)
Date: Wed, 2 Jul 2014 10:54:26 -0700
Subject: [RFC PATCH] arm64: Add arch support for PCI
In-Reply-To: <805EF793-7CA2-4F4A-B7D2-0AF2582EFFAA@codeaurora.org>
References: <1382529163-31968-1-git-send-email-tinamdar@apm.com>
 <1382531997.14960.8.camel@mbp>
 <CACoXjcmJPHdkrGRng8oWosgo9V_pLDNYw5Z3R_yN6w_rUe=G8Q@mail.gmail.com>
 <805EF793-7CA2-4F4A-B7D2-0AF2582EFFAA@codeaurora.org>
Message-ID: <CACoXjckS50sQGF54Go-FeoN3MfiX=SXb7s6wYKynBr8BoH8a8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 11:57 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Nov 21, 2013, at 7:38 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
>
>> This patch adds the PCI(e) arch support in arm64. The files are
>> based on PCI(e) support in 32bit arm.
>>
>>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>> ---
>> arch/arm64/Kconfig               |   19 ++
>> arch/arm64/include/asm/dma.h     |   18 +
>> arch/arm64/include/asm/pci.h     |   74 ++++
>> arch/arm64/include/asm/pcibios.h |   98 ++++++
>> arch/arm64/kernel/Makefile       |    1 +
>> arch/arm64/kernel/pcibios.c      |  689 ++++++++++++++++++++++++++++++++++++++
>> arch/arm64/mm/Makefile           |    2 +-
>> arch/arm64/mm/iomap.c            |   31 ++
>> drivers/pci/Makefile             |    1 +
>> 9 files changed, 932 insertions(+), 1 deletion(-)
>>
>> create mode 100644 arch/arm64/include/asm/dma.h
>> create mode 100644 arch/arm64/include/asm/pci.h
>> create mode 100644 arch/arm64/include/asm/pcibios.h
>> create mode 100644 arch/arm64/kernel/pcibios.c
>> create mode 100644 arch/arm64/mm/iomap.c
>
> Do you mind reposting this, the version I can find on mailing list archives seems corrupt.  This is at least useful until we get something merged upstream for arm64 pci work.

Sure. I have a patch that applies to 3.13 Linux Kernel. I will post that out.

>
> thanks
>
> - k
>
>
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
