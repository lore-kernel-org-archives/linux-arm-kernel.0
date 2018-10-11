From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 11 Oct 2018 12:18:20 +0000
Subject: [PATCH 5/5] RISC-V: Implement sparsemem
In-Reply-To: <mhng-c93e2f59-7121-4964-bd61-3c4c02044cf3@palmer-si-x1c4>
References: <20181005161642.2462-6-logang@deltatee.com>
 <mhng-c93e2f59-7121-4964-bd61-3c4c02044cf3@palmer-si-x1c4>
Message-ID: <15C8B877-4BBE-47E1-98D1-945E9355E757@raithlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Palmer

> I don't really know anything about this, but you're welcome to add a
>    
>    Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks. I think it would be good to get someone who's familiar with linux/mm to take a look.
    
> if you think it'll help.  I'm assuming you're targeting a different tree for 
> the patch set, in which case it's probably best to keep this together with the 
> rest of it.

No I think this series should be pulled by the RISC-V maintainer. The other patches in this series just refactor some code and need to be ACK'ed by their ARCH developers but I suspect the series should be pulled into RISC-V. That said since it does touch other arch should it be pulled by mm? 

BTW note that RISC-V SPARSEMEM support is pretty useful for all manner of things and not just the p2pdma discussed in the cover.
    
> Thanks for porting your stuff to RISC-V!

You bet ;-)

Stephen
    
    
