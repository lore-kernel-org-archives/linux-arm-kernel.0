From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Feb 2016 08:21:32 +0100
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <20160218151552.GA1852@localhost.localdomain>
References: <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
 <20160119072917.GA13237@pengutronix.de>
 <1454295246.22151.6.camel@mtksdaap41>
 <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
 <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
 <56C4A875.6080908@gmail.com> <20160218105603.GE3939@pengutronix.de>
 <20160218151552.GA1852@localhost.localdomain>
Message-ID: <20160219072132.GM3939@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 07:15:54AM -0800, Eduardo Valentin wrote:
> Folks,
> 
> > > I think the problem is, that Eduardo wants to see the hierachical thermal
> > > zones being used. But there is still a discussion ongoing [1].
> > 
> > It seems the original Author lost interest in the hierarchical thermal
> > zones. I am not convinced that we need hierarchical thermal zones for
> > the Mediatek driver since from the five sensors we only need the maximum
> > temperature (If this ever changes we could still rework it).
> > 
> > Given the current speed of communication I am not willing to add
> > another, possibly controversal, dependency to an otherwise simple
> > driver. I am even less willing when concerns like these come after *v12*
> > of this series.
> > 
> > Eduardo, it would really help to get a word from you.
> 
> Apologize for the long delays here. In fact I want the hierarchical
> support on this driver. But given that it is not really a strong
> dependency and the hierarchical support is still an ongoing development,
> I don't see why we should not merge this driver.
> 
> I also have had the chance to try it out in a board, and seams to work
> for me. I am adding to my tree.

Thanks for applying :)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
