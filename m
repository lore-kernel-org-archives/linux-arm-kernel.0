From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Dec 2013 14:40:10 +0000
Subject: [PATCH v4 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <20131204142954.GW29268@sirena.org.uk>
References: <cover.1386108712.git.stefan@agner.ch>
 <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
 <20131204121424.GN29268@sirena.org.uk>
 <0983a0fa016faa5674834afad4472413@agner.ch>
 <20131204142954.GW29268@sirena.org.uk>
Message-ID: <20131204144010.GA26581@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Acked-by: Mark Brown <broonie@linaro.org>
> 
> > > I won't apply since I think that patch 3 needs to go along with this,
> > > unless people decide the regulator tree is the easiest way to merge.
> 
> > I merged the dependent DT changes into that patch, so from my side,
> > patch 3 don't needs to go along with this...
> 
> OK, though now I look I see it also depends on patch 1 itself so at
> least those two will need to go together.

Well as I've already applied patch 1, I can take this too, no problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
