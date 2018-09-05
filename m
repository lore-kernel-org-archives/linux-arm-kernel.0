From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 5 Sep 2018 15:57:41 +0200
Subject: [PATCH 11/13] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <20180905095738.26406-12-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
 <20180905095738.26406-12-brgl@bgdev.pl>
Message-ID: <20180905155741.22b7d0ef@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  5 Sep 2018 11:57:36 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

>  
> +struct nvmem_cell_lookup {
> +	const char		*nvmem_name;
> +	const char		*dev_id;

Shouldn't we have a con_id here?

> +	const char		*cell_id;
> +	struct list_head	node;
> +};
