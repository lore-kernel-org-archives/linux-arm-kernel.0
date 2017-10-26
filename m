From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 26 Oct 2017 09:21:13 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171026070815.GA20634@amd>
References: <20171025203459.GA22035@amd>
 <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
 <20171026070815.GA20634@amd>
Message-ID: <20171026072113.z5bqer7os62ckf3z@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 October 2017 09:08:15 Pavel Machek wrote:
> On Thu 2017-10-26 08:25:02, Filip Matijevi? wrote:
> > Last time I couldn't get output on serial I used CONFIG_DEBUG_LL,
> > CONFIG_DEBUG_OMAP3UART3, CONFIG_EARLY_PRINTK... and ignore_loglevel
> > earlyprintk kernel params to get output early enough - I guess you
> > already tried that.
> 
> I realized I'm not getting output from the decompessor (even on "S"
> machine), and enabled that.

That is because you have not enabled those EARLY PRINK or DEBUG LL.
Similar thing is needed for N900 and IIRC in some of my linux-n900
branches I have config for it. Plus it needs patching some arch/arm
source files to make it working.

> But I'm _still_ not getting any output on decompressor... early
> printing works ok on "S" but not on "P".

I guess there can be either problem with memory mapping and RAM size or
with OMAP HS mode?

-- 
Pali Roh?r
pali.rohar at gmail.com
