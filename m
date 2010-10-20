From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 20 Oct 2010 11:14:31 +0200
Subject: [patch 3/9] imx51: enhance/fix iomux configuration
In-Reply-To: <20101019205254.232673283@rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205254.232673283@rtp-net.org>
Message-ID: <4CBEB2F7.5020700@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

in this patch, you break configuration for all the GPIO_1_x here (the correct 
lat mux for GPIO mode on pins GPIO_1_x is 1 and not 0).

Eric
