From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 24 Feb 2011 14:18:18 -0800
Subject: [PATCH 1/2] lib: vsprintf: optimised put_dec() function
In-Reply-To: <op.vrfg66mgvgw7ix@mnazarewicz-glaptop>
References: <a02a83033d5d61c5d78f110b44f24ae5cd94ab06.1298384703.git.mina86@mina86.com>
	<20110224135101.9205d91e.akpm@linux-foundation.org>
	<op.vrfg66mgvgw7ix@mnazarewicz-glaptop>
Message-ID: <20110224141818.7fd0207f.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Feb 2011 23:10:09 +0100
"Michal Nazarewicz" <mnazarewicz@google.com> wrote:

> On Thu, 24 Feb 2011 22:52:42 +0100, Andrew Morton wrote:
> > Also, the funky indenting to align on the "=" is atypical for kernel
> > code and is inconsistent with the rest of vsprintf.c.  Just a single
> > space, please.
> 
> Want me to resubmit with spaces fixed?

nah, we'll live.

I'd prefer that you find a workload where it actually matters :)
