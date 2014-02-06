From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 06 Feb 2014 12:01:16 +0000
Subject: [PATCH 1/3] mmc: tmio-mmc: add DMA SG synchronisation
In-Reply-To: <Pine.LNX.4.64.1401311248320.3234@axis700.grange>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
 <Pine.LNX.4.64.1401311248320.3234@axis700.grange>
Message-ID: <52F3798C.4040906@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/14 11:54, Guennadi Liakhovetski wrote:
> According to the DMA API data has to be synchronised before starting
> a DMA transfer to device and after completing a DMA transfer from device.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I've got 1/3 and 2/3, but not 3/3 ?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
