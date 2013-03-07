From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Mar 2013 19:30:22 -0500
Subject: [PATCH 2/4] arm: plat-orion: fix address decoding when > 4GB
 is used
In-Reply-To: <1362565416-15718-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362565416-15718-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130307003022.GQ23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 11:23:34AM +0100, Thomas Petazzoni wrote:
...
> This is a slightly updated version compared to the one sent on
> February 27th on LAKML. The earlier version was looking at the three
> low-order bits, but in fact there are four low-order bits to encode
> the high bits of the base address. So the mask was changed from 0x7 to
> 0xF.
> 
> Since I've changed the patch, I haven't kept the Tested-by from Lior
> Amsalem, Gr?gory Clement and Ezequiel Garcia.

Then please don't send this as part of a pull-request.  Threading it
under a pull-request implies that it is ready to be applied, causing
most reviewers/testers to ignore the email.  Please have Lior, Gr?gory,
and Ezequiel retest and report back.

thx,

Jason.
