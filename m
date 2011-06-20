From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 12:16:29 +0100
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate
	linux/leds.h include
In-Reply-To: <alpine.LNX.2.00.1106201232530.18991@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
	<4DFF1AA5.80508@ru.mvista.com>
	<alpine.LNX.2.00.1106201232530.18991@swampdragon.chaosbits.net>
Message-ID: <20110620111629.GC26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 12:34:37PM +0200, Jesper Juhl wrote:
> On Mon, 20 Jun 2011, Sergei Shtylyov wrote:
> 
> > Hello.
> > 
> > On 20-06-2011 12:40, Jesper Juhl wrote:
> > 
> > > Remove the duplicate inclusion of linux/leds.h from
> > > arch/arm/mach-s3c2410/h1940-bluetooth.c that was added by commit 50e2d10d.
> > 
> >    Pelase also specify that commit's summary in parens.
> > 
> 
> Anyone can just do a "git show 50e2d10d" to read it. But sure, here's a 
> new patch description:

Anyone with git can.  Those without git can't (eg, because they're using
some other tool for source management.)  This is why Linus requires commit
IDs to be followed by their summary.

Please ensure that you always include the summary along with the git commit
id.
