From: stefan.bruens@rwth-aachen.de (Stefan Bruens)
Date: Mon, 4 Sep 2017 02:13:15 +0200
Subject: [PATCH 08/10] dmaengine: sun6i: Add support for Allwinner A64 and
 compatibles
In-Reply-To: <1526a6b4-1962-256d-1ada-ef9c7d95e6b1@arm.com>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-9-stefan.bruens@rwth-aachen.de>
 <1526a6b4-1962-256d-1ada-ef9c7d95e6b1@arm.com>
Message-ID: <5368262.YgOfWCUmp3@pebbles.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 4. September 2017 01:37:58 CEST Andr? Przywara wrote:

> > @@ -1090,6 +1101,7 @@ MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> > 
> >  static int sun6i_dma_probe(struct platform_device *pdev)
> >  {
> >  
> >  	const struct of_device_id *device;
> > 
> > +	struct device_node *np = pdev->dev.of_node;
> 
> Is this some rebase/split artefact?
> 
> Cheers,
> Andre.
> 

Yes, that one should be in patch 7/10 ...

Kind regards,

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
