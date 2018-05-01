From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 17:20:20 +0530
Subject: [PATCH] ARM: davinci: board-dm355-evm: fix broken networking
In-Reply-To: <20180425092323.21898-1-nsekhar@ti.com>
References: <20180425092323.21898-1-nsekhar@ti.com>
Message-ID: <048d9032-6eaa-cb0e-c524-5a97b501cf19@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 April 2018 02:53 PM, Sekhar Nori wrote:
> Since commit 09f3756bb9a8 ("dm9000: Return an ERR_PTR() in all
> error conditions of dm9000_parse_dt()"), passing either non-NULL
> platform data or device-tree for dm9000 driver to probe is
> mandatory.
> 
> DM335 board was using none, so networking failed to initialize.
> Fix it by passing non-NULL (but empty) platform data.
> 
> Fixes: 09f3756bb9a8 ("dm9000: Return an ERR_PTR() in all error conditions of dm9000_parse_dt()")
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied to fixes.

Thanks,
Sekhar
