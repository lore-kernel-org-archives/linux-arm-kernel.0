From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 8 Mar 2013 11:26:10 -0500
Subject: [PATCH 07/12] mtd: gpmi: move to use generic DMA helper
In-Reply-To: <1362748785.5101.4.camel@sauron.fi.intel.com>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-8-git-send-email-shawn.guo@linaro.org>
 <1362748785.5101.4.camel@sauron.fi.intel.com>
Message-ID: <CAMiH66EDjSAZLf-gtR-_kMasdKSKGRMrPThxtyw_RAixeNXHug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 8, 2013 at 8:19 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2013-02-27 at 23:25 +0800, Shawn Guo wrote:
>> With the generic DMA device tree helper supported by mxs-dma driver,
>> client devices only need to call dma_request_slave_channel() for
>> requesting a DMA channel from dmaengine.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Artem Bityutskiy <dedekind1@gmail.com>
>> Cc: linux-mtd at lists.infradead.org
>
> It looks like this ne is rather independent and can go via the MTD tree.
> So pushed this one to l2-mtd.git - let me know if I am confused. Thanks!
I suggest do not apply this patch. the whole patch set is still under
review now.

Best Regards
Huang Shijie

>
> --
> Best Regards,
> Artem Bityutskiy
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
