From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Thu, 28 Jun 2012 21:28:50 +0530
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Message-ID: <CAAe_U6L7hMyxEYTOHShkcivdB91PxKa5OA7Q0w2Lw6zyXjXYXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 27, 2012 at 11:11 AM, N, Mugunthan V <mugunthanvnm@ti.com> wrote:
>> -----Original Message-----
>> From: N, Mugunthan V
>> Sent: Thursday, June 07, 2012 9:52 PM
>> To: 'linux-omap at vger.kernel.org'
>> Cc: 'linux-arm-kernel at lists.infradead.org'
>> Subject: how to specify dma_mask and coherent_dma_mask in hwmod
>>
>> Hi
>>
>> While converting platform device registry to Hwmod for CPSW Ethernet
>> driver which is present in AM335X (OMAP2+), I am not finding a way to
>> specify
>> dma_mask and coherent_dma_mask.
>> Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
>
> Ping, any one has comment on this?
>
Nope. You can specify dma_mask after creating the device as done in
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/usb-musb.c;h=c4a576856661014ea3bec9acc70f80e32d62c33b;hb=HEAD

Regards
Kishon
