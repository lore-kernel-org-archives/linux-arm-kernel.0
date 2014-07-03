From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 19:14:25 +0100
Subject: [PATCHv4 2/5] lib/genalloc.c: Add genpool range check function
In-Reply-To: <1404324218-4743-3-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140703181425.GK17372@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 07:03:35PM +0100, Laura Abbott wrote:
> 
> After allocating an address from a particular genpool,
> there is no good way to verify if that address actually
> belongs to a genpool. Introduce addr_in_gen_pool which
> will return if an address plus size falls completely
> within the genpool range.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will
