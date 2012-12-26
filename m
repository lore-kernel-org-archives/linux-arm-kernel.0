From: davem@davemloft.net (David Miller)
Date: Wed, 26 Dec 2012 14:15:40 -0800 (PST)
Subject: [PATCH v2 0/2] cpts fixes for v3.8-rc2
In-Reply-To: <cover.1356331925.git.richardcochran@gmail.com>
References: <cover.1356331925.git.richardcochran@gmail.com>
Message-ID: <20121226.141540.163930025578455864.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 24 Dec 2012 08:19:08 +0100

> Changed in v2:
> Use clk_prepare_enable instead of clk_prepare + clk_enable.
> 
> The new cpts driver has two small issues, but it otherwise seems to be
> working in -rc1.

Both applied, thanks.
