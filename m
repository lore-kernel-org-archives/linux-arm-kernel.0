From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Thu, 30 Nov 2017 21:01:34 +0100
Subject: [PATCH v3 5/6] ARM: ep93xx: ts72xx: cosmetic: Add some
 description to ts72xx code
In-Reply-To: <BLUPR0101MB155444953DA2E47B0AEE80BFD0380@BLUPR0101MB1554.prod.exchangelabs.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130004510.23887-1-lukma@denx.de>
 <20171130004510.23887-6-lukma@denx.de>
 <BLUPR0101MB155444953DA2E47B0AEE80BFD0380@BLUPR0101MB1554.prod.exchangelabs.com>
Message-ID: <20171130210134.e6f23f8996e58e6adb79654b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hartley!

On Thu, 30 Nov 2017 17:23:02 +0000
Hartley Sweeten <HartleyS@visionengravers.com> wrote:

> > +/**********************************************************************
> > +***
> > + * IO map
> > + 
> > +***********************************************************************
> > +**/
> 
> There is also something funny with the patch. The lines above appear to be getting split incorrectly.

That's definitely not the case, I can apply the patch to 4.14 just fine and
there is no funny wrapping. But you are right about the rest, it should be
re-based.

-- 
Alexander Sverdlin.
