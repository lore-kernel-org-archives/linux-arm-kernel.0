From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Mar 2018 16:03:37 +0530
Subject: [PATCH] ARM: davinci: DA8XX: simplify CFGCHIP regmap_config
In-Reply-To: <1521137621-6491-1-git-send-email-david@lechnology.com>
References: <1521137621-6491-1-git-send-email-david@lechnology.com>
Message-ID: <9e517194-2189-4e05-388b-a0a97cb751b1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2018 11:43 PM, David Lechner wrote:
> Since commit 8253bb3f8255 ("regmap: potentially duplicate the name
> string stored in regmap"), the name field of struct regmap_config
> is copied in __regmap_init(), so we no longer need to worry about
> keeping our own copy of the name.
> 
> Just use a string literal in the initialization of da8xx_cfgchip_config
> instead of creating a separate variable for the name.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.17/soc of my tree.

Thanks,
Sekhar
