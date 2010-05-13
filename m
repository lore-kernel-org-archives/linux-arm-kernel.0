From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 13 May 2010 08:21:05 +0300
Subject: [PATCH 1/3] mx2_camera: Add soc_camera support for i.MX25/i.MX27
In-Reply-To: <Pine.LNX.4.64.1005090045230.10524@axis700.grange>
References: <cover.1273150585.git.baruch@tkos.co.il>
	<a029bab8fcb3273df4a1d98f779f110b127742bd.1273150585.git.baruch@tkos.co.il>
	<Pine.LNX.4.64.1005090045230.10524@axis700.grange>
Message-ID: <20100513052105.GA18678@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,
On Wed, May 12, 2010 at 09:02:29PM +0200, Guennadi Liakhovetski wrote:
> Thanks for eventually mainlining this driver! A couple of comments below.  
> Sascha, would be great, if you could get it tested on imx27 with and without 
> emma. BTW, if you say, that you use emma to avoid using the standard DMA 
> controller, why would anyone want not to use emma? Resource conflict? There 
> is also a question for you down in the comments, please, skim over.

Thank you very much for your detailed review and informative comments. I'll 
fix the problems that you've found, and post up updated patch after getting 
Sascha comments on the mx27 specific code.

baruch

> On Thu, 6 May 2010, Baruch Siach wrote:
> 
> > This is the soc_camera support developed by Sascha Hauer for the i.MX27.  Alan
> > Carvalho de Assis modified the original driver to get it working on more recent
> > kernels. I modified it further to add support for i.MX25. This driver has only
> > been tested on the i.MX25 platform.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
