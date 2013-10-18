From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Oct 2013 17:38:12 +0200
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20131018124832.GK2443@sirena.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20131018003439.GG2443@sirena.org.uk>
 <20131018103019.GW25034@n2100.arm.linux.org.uk>
 <20131018124832.GK2443@sirena.org.uk>
Message-ID: <20131018173812.74a23b52@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013 13:48:32 +0100
Mark Brown <broonie@kernel.org> wrote:

> > "widgets that manage the enable of the S/PDIF and I2S interfaces between
> > the FE and BE DAIs" is exactly what I did and you told me that was wrong.
> > Make up your fscking mind.  
> 
> No, this is not the case.  The major problem with your last set of
> patches was that they did not create any back end DAIs, instead they
> created purely DAPM routes from the single traditional DAI out to
> widgets in the CODEC.  What I'm asking Jean-Francois to do above is
> create and use back end DAIs.

Mark,

I think I understood what you mean. I am testing my system with this
new approach and I will submit a new patch as soon as it works.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
