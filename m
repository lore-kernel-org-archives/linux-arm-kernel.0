From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 16 Mar 2015 12:43:47 -0400 (EDT)
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for
 Revision
In-Reply-To: <20150316161449.GJ8656@n2100.arm.linux.org.uk>
References: <201502271645.58765@pali>
 <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
 <20150302112836.GA27317@amd> <20150316154409.GQ5264@atomide.com>
 <20150316161449.GJ8656@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1503161238560.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Mar 2015, Russell King - ARM Linux wrote:

> In any case, I'm currently not accepting /any/ patches into my tree at
> present; I'm chasing a horrid instability on one of my test platforms
> which is making it impossible to tell whether any particular change or
> changes in my tree is responsible or not for it.  It doesn't seem to be
> a hardware failure (if it was, I'd simply take the board out of the
> nightly test system.)
> 
> It's quite literally taking hours to figure out what's going on - I've
> been on this for about 12 hours now and still not much closer to knowing
> what's causing it (other than I know that -rc1 plus my queue seems to be
> fine, -rc3 plus my queue is definitely broken, -rc3 alone is fine.  So
> something I'm already carrying seems to be responsible, but each time I
> identify a particular patch and drop _just_ that change, I find that the
> problem is back when I try my queue minus the bad changes.  With a test
> cycle time of 20+ minutes (due to the number of boots required to make
> certain of a dependable result), this is /really/ slow progress.
> 
> Right now, I can't be positively sure that /anything/ I have already
> merged isn't a factor in causing this problem, so I don't want to
> augment my tree with any additional patches which would upset my
> ability to move about in the tree, and get reproducable results from
> repeated testing.  To merge something else will probably mean I'll
> have to start again from the beginning and the last 12 hours spent
> testing will have been wasted.

Your publicly visible tree contains only a few mundane patches.
Is that the tree you're testing with?  If no then could you publish it 
for others to have a look and test?


Nicolas
