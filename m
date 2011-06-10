From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Jun 2011 13:50:07 +0100
Subject: [RFC PATCH 3/5] w90x900: convert to basic-mmio-gpio
In-Reply-To: <BANLkTincujypx04vpogGyZ8c0SDz9uUUrg@mail.gmail.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<1302522502-24381-4-git-send-email-jamie@jamieiles.com>
	<BANLkTincujypx04vpogGyZ8c0SDz9uUUrg@mail.gmail.com>
Message-ID: <20110610125007.GO3711@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Apr 11, 2011 at 10:27:56PM +0800, Wan ZongShun wrote:
> 2011/4/11 Jamie Iles <jamie@jamieiles.com>:
> > The basic-mmio-gpio driver is capable of supporting this controller so
> > convert the platform to use it for basic GPIO support.
> >
> > Cc: Wan ZongShun <mcuos.com@gmail.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
> 
> Thanks, so you can submit it to Russell for merging.

All of the dependencies for this are now merged, is it okay to put this 
one in the patch system?

Jamie
