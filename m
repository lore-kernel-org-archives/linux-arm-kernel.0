From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Jun 2011 20:46:35 +0200
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA202CA6E@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<4E033041.9090606@criticallink.com>
	<FFF198FBBF957F4393BA834040FEFFA202CA6E@DFLE35.ent.ti.com>
Message-ID: <201106232046.35846.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 June 2011 18:27:10 Grosen, Mark wrote:
> First, we are not abandoning DSPLINK. We have many users of this, even
> though it is out-of-tree, and we will continue to support it. That said, we
> do intend to make this new design the basis for DSPLINK-like
> functionality. It's designed to be done "the right way" for Linux (and we
> are looking for feedback to make it better).  It is also designed to be more
> scalable and extensible in userspace. With a solid kernel foundation, we can
> provide lots of functionality in userspace, or users can implement their own
> custom solutions. One of the key things to do is map our existing DSPLINK
> APIs, like MessageQ, to the new rpmsg transport.

Sounds all good. What about the PRUSS code? Does that fit into the new model
as well?

	Arnd
