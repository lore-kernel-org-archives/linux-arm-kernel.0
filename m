From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 13:14:15 +0100
Subject: [PATCH 4/9] regulator: twl: Make twl-regulator driver extract
	data from DT
In-Reply-To: <1317118372-17052-5-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-5-git-send-email-rnayak@ti.com>
Message-ID: <20110927121415.GC4289@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:42:47PM +0530, Rajendra Nayak wrote:

> +#ifdef CONFIG_OF
> +	char			compatible[128];
> +#endif

Might it not be better to just make this a pointer to const char?
