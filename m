From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 26 Oct 2012 20:47:28 +0800
Subject: [PATCH] ARM: dma-mapping: support debug_dma_mapping_error
In-Reply-To: <20121026104355.GB21164@n2100.arm.linux.org.uk>
References: <1350909843-5273-1-git-send-email-ming.lei@canonical.com>
 <20121026104355.GB21164@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVP0j18izbpBcb2vngF=VUZcQN-16os_xTkyj5niS3tLPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 6:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 22, 2012 at 08:44:03PM +0800, Ming Lei wrote:
>> Without the patch, kind of below warning will be dumped if DMA-API
>> debug is enabled:
>>
>> [   11.069763] ------------[ cut here ]------------
>> [   11.074645] WARNING: at lib/dma-debug.c:948 check_unmap+0x770/0x860()
>> [   11.081420] ehci-omap ehci-omap.0: DMA-API: device driver failed to
>> check map error[device address=0x0000000
>> 0adb78e80] [size=8 bytes] [mapped as single]
>> [   11.095611] Modules linked in:
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>
> Would you mind explaining why you think it's fine to send a patch for the
> mainline kernel adding a function call to a header file which is not even
> in the mainline kernel?

Sorry, I should have made it explicitly that the patch is against -next tree.

Thanks,
--
Ming Lei
