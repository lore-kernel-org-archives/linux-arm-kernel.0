From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 06 Feb 2014 23:21:54 +0100
Subject: [PATCH] clk: samsung: Initialize clock table with error pointers
In-Reply-To: <1391711591-19416-1-git-send-email-t.figa@samsung.com>
References: <1391711591-19416-1-git-send-email-t.figa@samsung.com>
Message-ID: <52F40B02.8070403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 07:33 PM, Tomasz Figa wrote:
> Before this patch, the driver was simply zeroing the clock table, which
> is incorrect, because invalid clock numbers returned NULL instead of
> error pointers. This patch fixes this by changing the driver to
> initialize the array with PTR_ERR(-ENOENT).
>
> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> Acked-by: Kyungmin Park<kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
