From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 May 2011 21:28:08 +0100
Subject: [PATCH 1/2] Initial B&N Nook Color (encore) support.
In-Reply-To: <1304891407-29364-2-git-send-email-green@linuxhacker.ru>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru>
	<1304891407-29364-2-git-send-email-green@linuxhacker.ru>
Message-ID: <20110509202807.GA19492@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2011 at 05:50:06PM -0400, green at linuxhacker.ru wrote:

> +	/*
> +	 * link regulators to MMC adapters ... we "know" the
> +	 * regulators will be set up only *after* we return.
> +	 */
> +	encore_vmmc1_supply.dev = mmc[1].dev;

Just specify dev_name in the supply rather than doing this.
