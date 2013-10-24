From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 Oct 2013 13:10:22 -0000
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <1382619655.6040.52.camel@sakura.staff.proxad.net>
References: <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
 <1382619655.6040.52.camel@sakura.staff.proxad.net>
Message-ID: <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>
> On Thu, 2013-10-24 at 14:23 +0200, Thierry Reding wrote:
> my point
>
> before DT scenario for my hw crypto driver example:

Note that you are not describing a normal "DT scenario" here. You are
describing a case in which we screwed up and allowed non-invariant
features of the hardware to be left out of the DT schema for the device in
question - apparently because the Linux driver at the time didn't happen
to use them yet. That was a fundamental mistake and should not have
happened that way.

So yes, after the public flogging has happened, and we're trying to work
out how best to cope with the screwup, we don't necessarily have any
perfect choices. The perfect choice was to do it properly in the first
place.

-- 
dwmw2
