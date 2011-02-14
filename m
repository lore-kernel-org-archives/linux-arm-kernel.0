From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Mon, 14 Feb 2011 11:21:34 +0100
Subject: mc13xxx-core, support for i2c, V4
In-Reply-To: <20110212084035.GB17755@angua.secretlab.ca>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<20110212084035.GB17755@angua.secretlab.ca>
Message-ID: <201102141121.34676.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le samedi, 12 f?vrier 2011 09.40:35, Grant Likely a ?crit :
> On Tue, Jan 04, 2011 at 04:34:55PM +1100, Marc Reilly wrote:
> > Hi,
> >
> > These patches add i2c support for the mc13xxx-core drive. For v4 I've
> > tried to take in all previous comments, hopefully making it better to
> > follow, and bisectable.
> 
> This series looks okay to me.  Since this is audio drivers, I expect
> that it would best be taken via the ASoC tree?  Have you sent it to
> Mark Brown and the ALSA list for review?

AFAIK the audio part of the mc13783 has still not been merged.

Regards,

Philippe
