From: shuah.khan@hp.com (Shuah Khan)
Date: Thu, 15 Nov 2012 10:11:26 -0700
Subject: [PATCH linux-next] ARM64: dma-mapping: support
 debug_dma_mapping_error
In-Reply-To: <20121105164618.GF17864@arm.com>
References: <1351205220.6851.3.camel@lorien2>
 <CAHkRjk6jDKsFMa1_Wapwr7y5n8Ut8xfNBKWniSfHN_01z7qWFQ@mail.gmail.com>
 <1351264983.2712.14.camel@lorien2> <1351871933.2721.10.camel@lorien2>
 <20121105164618.GF17864@arm.com>
Message-ID: <1352999486.2532.18.camel@lorien2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 16:46 +0000, Catalin Marinas wrote:
> On Fri, Nov 02, 2012 at 03:58:53PM +0000, Shuah Khan wrote:
> > On Fri, 2012-10-26 at 09:23 -0600, Shuah Khan wrote:
> > > Add support for debug_dma_mapping_error() call to avoid warning from
> > > debug_dma_unmap() interface when it checks for mapping error checked
> > > status. Without this patch, device driver failed to check map error
> > > warning is generated. 
> > > 
> > > Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Do you want this patch going through linux-next or the ARM64 tree? Let
> > me know your preference.
> 
> I think it can go together with your other patches since I can't tell
> when you'll push the debug_dma_mapping_error() implementation.
> 

Marek,

This one is for ARM64 and ARM tree has already been fixed.

-- Shuah
