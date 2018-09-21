From: james.morse@arm.com (James Morse)
Date: Fri, 21 Sep 2018 23:26:39 +0100
Subject: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Message-ID: <2f97b06e-ba36-4f6f-e29d-a9747ad9ec75@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 09/17/2018 05:43 AM, Jun Yao wrote:
> Version 5 changes:
> 	1. Correct spelling and indentation errors[1].
> 	2. Update init_mm.pgd by assembly[2].
> 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> 	   during paging_init()[3].


For the series:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
