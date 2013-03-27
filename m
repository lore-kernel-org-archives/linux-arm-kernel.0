From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 14:59:49 +0900
Subject: [PATCH 0/3] ARM: shmobile: kzm9g: add irqpin to DT
In-Reply-To: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
Message-ID: <20130327055949.GR25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:05:33PM +0100, Guennadi Liakhovetski wrote:
> These 3 patches extend irqpin DT bindings to more completely support 
> sh73a0, add irqpin DT nodes to sh73a0.dtsi and use them to add ethernet 
> support to kzm9g-reference.

Hi Guennadi,

thanks for this. I am really happy to see this change.

I wonder if it might be possible for you to wire up similar changes
for the r8a7779/marzen. reference-marzen claims to support the SMSC LAN
in its dts file, however it doesn't work due to missing irqpin setup.

If so I can test any patches you make.
Or I can give you remote access to a marzen.
Whichever works best for you.
