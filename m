From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 29 Jun 2011 10:48:26 -0700
Subject: [PATCH 2/5] ASoC: atmel-ssc: add phybase in device structure
In-Reply-To: <a128473d585314a01420a5869949065a549119e3.1309368631.git.nicolas.ferre@atmel.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<a128473d585314a01420a5869949065a549119e3.1309368631.git.nicolas.ferre@atmel.com>
Message-ID: <20110629174822.GB13051@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 08:00:16PM +0200, Nicolas Ferre wrote:

>  struct ssc_device {
>  	struct list_head	list;
> +	resource_size_t		phybase;

The type here looks rather wrong?
