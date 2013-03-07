From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 11:30:16 +0100
Subject: [PATCH 2/4] arm: plat-orion: fix address decoding when > 4GB is
 used
In-Reply-To: <20130307003022.GQ23237@titan.lakedaemon.net>
References: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362565416-15718-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130307003022.GQ23237@titan.lakedaemon.net>
Message-ID: <20130307113016.6bbf5a7b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 6 Mar 2013 19:30:22 -0500, Jason Cooper wrote:

> > Since I've changed the patch, I haven't kept the Tested-by from Lior
> > Amsalem, Gr?gory Clement and Ezequiel Garcia.
> 
> Then please don't send this as part of a pull-request.  Threading it
> under a pull-request implies that it is ready to be applied, causing
> most reviewers/testers to ignore the email.  Please have Lior,
> Gr?gory, and Ezequiel retest and report back.

I believe it is ready to be applied. The change I've done from the
version tested by others is minor, and I'm quite convinced that the
change is OK. If the change had been more significant, I would for sure
not have sent this as a pull request.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
