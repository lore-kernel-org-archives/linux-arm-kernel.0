From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Nov 2010 11:08:02 +0000
Subject: [PATCH] ARM: l2x0: Check the correct address range
In-Reply-To: <20101119014029.GA26429@july>
References: <20101119014029.GA26429@july>
Message-ID: <AANLkTinqvbPB5ijJnMGB1FP08WUMSUKFY_qZhgZaVUci@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2010 01:40, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Boojin Kim <boojin.kim@samsung.com>
>
> When flush or clean the 1MiB, it doesn't flush or clean all since it doesn't check the correct address. So Check the correct address range.

This line is very long.

The patch looks fine otherwise. I think the optimal value would be
smaller than the whole cache size but it depends on many things.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
