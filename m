From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 20 Sep 2017 09:21:22 +0200
Subject: [PATCH] dmaengine: sun6i: sun4i-gpadc: use
 of_device_get_match_data
In-Reply-To: <20170920065814.fle73gxbu3oyqsr4@flea.home>
References: <20170919184447.4479-1-clabbe.montjoie@gmail.com>
 <20170920065814.fle73gxbu3oyqsr4@flea.home>
Message-ID: <20170920072122.GA19920@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 08:58:14AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Sep 19, 2017 at 06:44:47PM +0000, Corentin Labbe wrote:
> > The usage of of_device_get_match_data reduce the code size a bit.
> > Furthermore, it prevents an improbable dereference when
> > of_match_device() return NULL.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> The prefix of your commit title is wrong, this isn't about the GPADC.
> 
> Once fixed,
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Maxime
> 

A copy/paste error, sorry
I will resend
thanks
Corentin Labbe
