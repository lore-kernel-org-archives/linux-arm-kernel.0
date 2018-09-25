From: yaojun8558363@gmail.com (Jun Yao)
Date: Tue, 25 Sep 2018 16:56:18 +0800
Subject: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
In-Reply-To: <2f97b06e-ba36-4f6f-e29d-a9747ad9ec75@arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <2f97b06e-ba36-4f6f-e29d-a9747ad9ec75@arm.com>
Message-ID: <20180925085618.GA26696@toy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Sep 21, 2018 at 11:26:39PM +0100, James Morse wrote:
> Hi Jun,
> 
> On 09/17/2018 05:43 AM, Jun Yao wrote:
> > Version 5 changes:
> > 	1. Correct spelling and indentation errors[1].
> > 	2. Update init_mm.pgd by assembly[2].
> > 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> > 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> > 	   during paging_init()[3].
> 
> 
> For the series:
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you very much for helping me improve the patch and tolerate the
mistakes I made.

Thanks,

Jun
