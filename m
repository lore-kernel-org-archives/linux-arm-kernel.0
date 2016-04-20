From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Apr 2016 10:35:50 +0100
Subject: [PATCH] arm64: spin-table: add missing of_node_put()
In-Reply-To: <1461115411-2843-1-git-send-email-yamada.masahiro@socionext.com>
References: <1461115411-2843-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160420093549.GH8482@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:23:31AM +0900, Masahiro Yamada wrote:
> Since of_get_cpu_node() increments refcount, the node should be put.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued for 4.6. Thanks.

-- 
Catalin
