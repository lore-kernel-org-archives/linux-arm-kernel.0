From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Jan 2011 18:02:56 -0000
Subject: [PATCH] arm: Configure reference clock for Versatile
	Express	timers
In-Reply-To: <20110118174428.GG16980@n2100.arm.linux.org.uk>
References: <1295368773-14531-1-git-send-email-pawel.moll@arm.com>
	<20110118174428.GG16980@n2100.arm.linux.org.uk>
Message-ID: <000001cbb739$ef879490$ce96bdb0$@moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch performs required magic and also removes code clearing
> > timer's control registers, as exactly the same operations are
> > performed by the timer driver few jiffies later.
> It would be nice if these registers were documented...

The best I can do is to create some more meaningful constants.

V2 to follow...

Pawe?
