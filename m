From: pc.liao@mediatek.com (PC Liao)
Date: Wed, 20 Apr 2016 17:39:50 +0800
Subject: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <20160420082917.GH3217@sirena.org.uk>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
 <20160420082917.GH3217@sirena.org.uk>
Message-ID: <1461145190.3774.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2016-04-20 at 16:29 +0800, Mark Brown wrote:
> On Wed, Apr 20, 2016 at 02:40:47PM +0800, PC Liao wrote:
> 
> > +Optional properties:
> > +- capture-dai: audio codec dai on capture path
> > +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> > +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
> 
> I sugggested changing this to use a subnode but you've ignored my
> suggestion...

Sorry.... It's my mistake.

You mean that using a subnode.
This is my example:

  codec-capture {
	  sound-dai = <&rt5650 1>;
  };

Does this is your suggestion?
Thanks!
