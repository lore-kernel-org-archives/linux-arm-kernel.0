From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 19 Jun 2012 18:38:15 -0700
Subject: [PATCH 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <CACDDiy-mMShDv9GiRiy_OhceGdStgSLdQNNwo1V_ADpnANeUeA@mail.gmail.com>
References: <1332825916-2183-1-git-send-email-jtzhou@marvell.com>
 <20120506022954.GB29576@lizard>
 <20120507091001.GB4415@opensource.wolfsonmicro.com>
 <CACDDiy-mMShDv9GiRiy_OhceGdStgSLdQNNwo1V_ADpnANeUeA@mail.gmail.com>
Message-ID: <20120620013814.GA7246@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jett,

On Mon, May 07, 2012 at 06:08:34PM +0800, jett zhou wrote:
> Got it. I will rebase to the latest regulator tree code base to amend these
> patches.

Any news on these patches?

Thanks,

> 2012/5/7 Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> > On Sat, May 05, 2012 at 07:29:54PM -0700, Anton Vorontsov wrote:
> >
> > > OK to let me take this via battery tree?
> >
> > No, there's now substantial conflicts with the regulator driver's
> > ongoing development.  For example, the driver has been converted to use
> > the core regmap support for enable and disable.

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
