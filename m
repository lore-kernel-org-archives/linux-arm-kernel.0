From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Mon, 12 Mar 2012 09:11:08 +0100
Subject: [PATCH 1/4] add a mc13783 codec driver
In-Reply-To: <20120311113848.GA3233@opensource.wolfsonmicro.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <20120311113848.GA3233@opensource.wolfsonmicro.com>
Message-ID: <1496586.ebXd01ibP4@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche 11 mars 2012 11:38:48 Mark Brown a ?crit :
> On Fri, Mar 09, 2012 at 03:55:13PM +0100, Philippe R?tornaz wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > sha 20111307:
> > - rebased to 3.0-rc2
> > - implement tdm slot settings
> > - made it work with single ssi port
> > - more register names instead of hardcoded numbers
> > 
> > philippe 20120803:
> > - Add headset detection
> > - add mic2 bias
> > - enable headset output by default
> 
> If including stuff like this please include it after the ---.  Things
> like notes about the odd arrangements with the SSI ports which will have
> ongoing meaning are much more useful in the changelog.
> 
> Overall this looks fairly clean but very out of date, for example
> there's a custom register cache impelementation and no DAPM.

Thank you for this detailed review. I will redo the patch based on your 
comments. I had a quick look at DAPM (dapm.txt in asoc documentation), but is 
there any good "reference" implementation which is in the kernel where I could 
have a look ? 

Thanks,

Philippe
