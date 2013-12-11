From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 11 Dec 2013 14:06:07 -0500
Subject: [PATCH 0/8] Impedance matcher for Samsung boards
In-Reply-To: <52A88286.2030401@gmail.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <005d01cef679$be770570$3b651050$%wilczek@samsung.com>
 <52A8725F.2020403@gmail.com> <1837099.JIoGixjT73@amdc1227>
 <52A88286.2030401@gmail.com>
Message-ID: <20131211190607.GE10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 04:19:34PM +0100, Daniel Mack wrote:
> What bugs me, though, is that it blows up the code base so massively.

compile-time option?

> So I'm about to merge this. Jason, and final thoughts?

Just the location of the libfdt files.  But that's not a show stopper.

It would make the delineation cleaner and having a libfdt.a is easier to
make optional at compile-time if we want.

thx,

Jason.
