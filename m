From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 10 Apr 2016 23:02:30 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check
 sequence
In-Reply-To: <570AC1EA.3030501@ti.com>
References: <1459812638-38789-1-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.02.1604101840270.11457@utopia.booyaka.com>
 <570AC1EA.3030501@ti.com>
Message-ID: <alpine.DEB.2.02.1604102302080.11457@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman

On Sun, 10 Apr 2016, Suman Anna wrote:

> >> There are couple of pr_debug statements that only print once the code
> >> flow passes through certain conditions. Not sure if you wanted them
> >> to be printed first thing when entering the functions or only if the
> >> function is really doing something. But it is still not consistent
> >> between _enable(), _idle() and _shutdown().
> > 
> > Yeah those need to be cleaned up.  Seems like the best thing to do 
> > is to move them all to the beginning of their respective functions.
> 
> You want that fixed in this patch or a separate patch?

A separate one would be great.  No rush



- Paul
