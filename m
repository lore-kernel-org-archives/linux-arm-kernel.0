From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 08:34:33 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <4FA1F499.8000408@jonmasters.org>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <20120430190015.GV24211@n2100.arm.linux.org.uk>
 <4FA1F499.8000408@jonmasters.org>
Message-ID: <20120503073433.GC24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 10:59:37PM -0400, Jon Masters wrote:
> So given that Will's replacement works in my investigation, etc. Can you
> pull that please with my reported/tested-by ACK? I think it's a stable
> candidate too. I mean, ok, it won't crash your system unless you have
> audit capability, but it's still a good idea to fix I think.

Not only what Viro said, but... that's not how things work in any Linux
community.

1. Changes get pulled upstream only when the git tree owner is ready to
   have the changes pulled, which is indicated by them sending a pull
   request.

2. The person pulling someone elses git tree _never_ modifies commits
   which have been pulled from someone elses git tree, and that includes
   modifying them to add acks and such like.  If Will is handling the
   patch, then you need to ask Will to add your attributations.

The final point is that I've no idea until Will sends a pull request what
the git tree URL is to pull this change.

Please, wait for the proper process to happen.
