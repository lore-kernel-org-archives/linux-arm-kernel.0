From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 10 Sep 2009 15:33:27 +0200
Subject: [PATCH] video: add PXA3xx accelerator ID [v2]
In-Reply-To: <Pine.LNX.4.64.0909101530120.4458@axis700.grange>
References: <20090910132630.GZ9410@buzzloop.caiaq.de>
	<Pine.LNX.4.64.0909101530120.4458@axis700.grange>
Message-ID: <20090910133327.GA9410@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 03:31:34PM +0200, Guennadi Liakhovetski wrote:
> > +	if (cpu_is_pxa3xx() && inf->acceleration_enabled)
> > +		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
> > +
> 
> Ok, now remove 'cpu_is_pxa3xx() && ' above and you should be good to go:-) 
> What if tomorrow pxa4xx comes (ok, Eric will disagree, but wtill:-))

Don't know. I left it in there intentionally, but I'm fine to remove it.
Or Eric does it when applying ;) Eric?

Daniel
