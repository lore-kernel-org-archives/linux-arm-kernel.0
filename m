From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 20 Oct 2010 12:41:54 +0300
Subject: [patch 3/9] imx51: enhance/fix iomux configuration
In-Reply-To: <4CBEB3D8.40900@eukrea.com>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205254.232673283@rtp-net.org> <4CBEB3D8.40900@eukrea.com>
Message-ID: <20101020094154.GI2562@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 20, Eric B?nard wrote:
> Hi Arnaud,
> 
> Le 19/10/2010 22:42, Arnaud Patard (Rtp) a ?crit :
> > - ALT0 is used to set GPIO mode of GPIO_1_{2,3,4,5,6,7,8,9} but it's ALT1
> for GPIO_1_{0,1}.
> 
> oops sorry forget my previous mail, in fact I think I broke
> GPIO_1_{2,3,4,5,6,7,8,9} in a previous patch when fixing
> GPIO_1_{0,1} :-(
> Thanks for noticing and fixing this.

I did wonder where they got flipped from Alt 0 to Alt 1 in the first place.
Just noticed your patch in Sascha's tree.

/Amit
