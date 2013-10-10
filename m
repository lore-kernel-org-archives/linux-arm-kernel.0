From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 10 Oct 2013 15:02:14 -0700
Subject: [GIT PULL] Second round of Renesas ARM based SoC cleanups for
 v3.13
In-Reply-To: <20131009045354.GA8369@verge.net.au> (Simon Horman's message of
 "Wed, 9 Oct 2013 13:53:54 +0900")
References: <cover.1381222967.git.horms+renesas@verge.net.au>
 <20131009045354.GA8369@verge.net.au>
Message-ID: <87k3hkokd5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms@verge.net.au> writes:

> On Tue, Oct 08, 2013 at 06:05:24PM +0900, Simon Horman wrote:
>> Hi Kevin, Olof and Arnd,
>> 
>> please consider this Second round of Renesas ARM based SoC cleanups for v3.13.
>> It is based on renesas-cleanup-for-v3.13 which you have previously pulled.
>
> This pull-request causes some conflicts in
> arch/arm/mach-shmobile/board-bockw.c. In general the resolution
> strategy should be to take everything.

Thanks for the heads up.  I assume you meant board-lager.c though,
right?  That's where I saw the conflict.

Kevin
