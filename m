From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue,  8 Nov 2011 18:19:35 -0700
Subject: [RFC 0/8] Initial DT clock bindings
Message-ID: <1320801583-12774-1-git-send-email-grant.likely@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all, here is an initial implementation of the DT clock bindings
with the versatile platform modified to use them.  I'm fairly happy
with how this has turned out, although I'll probably roll the clock
lookup stuff directly into drivers/clk/clkdev.c which will simplify
things a bit.  Please take a look and comment.

You'll also notice that I've started adding selftests to the
devicetree code, which turned out to be pretty useful for debugging.
I think I want to do this for a lot of the dt infrastructure.

The first 5 patches are probably pretty close to ready to be merged,
the last 3 I expect to still need work.

g.
