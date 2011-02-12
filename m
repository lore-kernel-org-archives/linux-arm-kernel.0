From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 12 Feb 2011 01:40:35 -0700
Subject: mc13xxx-core, support for i2c, V4
In-Reply-To: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <20110212084035.GB17755@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 04:34:55PM +1100, Marc Reilly wrote:
> Hi,
> 
> These patches add i2c support for the mc13xxx-core drive. For v4 I've tried to take
> in all previous comments, hopefully making it better to follow, and bisectable.

This series looks okay to me.  Since this is audio drivers, I expect
that it would best be taken via the ASoC tree?  Have you sent it to
Mark Brown and the ALSA list for review?

g.
