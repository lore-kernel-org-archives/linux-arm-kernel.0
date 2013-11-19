From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Nov 2013 15:21:46 +0000
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119152047.GB28859@titan.lakedaemon.net>
References: <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
 <20131119150212.GM16735@n2100.arm.linux.org.uk>
 <20131119152047.GB28859@titan.lakedaemon.net>
Message-ID: <20131119152146.GN16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 10:20:47AM -0500, Jason Cooper wrote:
> By "That" are you referring to extending the standard for compatible
> strings to the board level, or forcing consistent naming on the dts
> files?

A consistent file naming on both the dtb and dts files.
