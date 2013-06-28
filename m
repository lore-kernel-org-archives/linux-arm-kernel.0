From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Jun 2013 21:05:56 +0100
Subject: Armada DRM driver on OLPC XO
In-Reply-To: <CAMLZHHQNB4Y16rg2052wpZosaUuCC_oYpq0DKp=uHSuPg-Z53g@mail.gmail.com>
References: <20130625204726.BF65C12647A@dev.laptop.org>
 <20130626184250.43f36e47@armhf>
 <CAMLZHHQNB4Y16rg2052wpZosaUuCC_oYpq0DKp=uHSuPg-Z53g@mail.gmail.com>
Message-ID: <20130628200556.GI4283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 01:54:21PM -0600, Daniel Drake wrote:
> On Wed, Jun 26, 2013 at 10:42 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > Do you know that there are 2 drm drivers for the Cubox? I posted mine
> > (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168732.html)
> > before Russell, but I got no return about it yet.
> 
> I thought there was some agreement that you would merge your efforts
> into Russell's driver. Is that still the plan?
> 
> Thanks for the links - I think we can learn something about timer
> handling from your work. I'll send a patch shortly incorporating the
> basis of something like this into armada_drm.

Note that my driver has changed significantly since the last posting;
it's now using drm planes and also dmabuf stuff to limited extents
(because dmabuf is technically misdesigned for CPUs with noncoherent
DMA.)
