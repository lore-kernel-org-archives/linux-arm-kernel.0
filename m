From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Nov 2013 15:02:12 +0000
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119142336.GA28859@titan.lakedaemon.net>
References: <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
Message-ID: <20131119150212.GM16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 09:23:36AM -0500, Jason Cooper wrote:
> All I'm suggesting doing is extending the same standard we have for
> compatible strings at the node level to the board level.  If we don't
> change the filename, then we *have* to extend the consistent naming to
> the dts files as well.

That, in itself, is not a bad thing to do, and totally solves the problem.
