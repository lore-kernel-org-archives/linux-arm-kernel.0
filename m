From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 20 Oct 2010 11:18:16 +0200
Subject: [patch 3/9] imx51: enhance/fix iomux configuration
In-Reply-To: <20101019205254.232673283@rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205254.232673283@rtp-net.org>
Message-ID: <4CBEB3D8.40900@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Le 19/10/2010 22:42, Arnaud Patard (Rtp) a ?crit :
 > - ALT0 is used to set GPIO mode of GPIO_1_{2,3,4,5,6,7,8,9} but it's ALT1
for GPIO_1_{0,1}.

oops sorry forget my previous mail, in fact I think I broke 
GPIO_1_{2,3,4,5,6,7,8,9} in a previous patch when fixing GPIO_1_{0,1} :-(
Thanks for noticing and fixing this.

Eric
