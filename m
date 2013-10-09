From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 09 Oct 2013 13:20:06 -0700
Subject: [GIT PULL V2] ARM: mvebu: driver changes for v3.13
In-Reply-To: <20131008154911.GH5402@titan.lakedaemon.net> (Jason Cooper's
 message of "Tue, 8 Oct 2013 11:49:11 -0400")
References: <20130930153643.GF31178@titan.lakedaemon.net>
 <20131007170206.GE15413@quad.lixom.net>
 <20131008154911.GH5402@titan.lakedaemon.net>
Message-ID: <87vc16tcw9.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> Olof,
>
> Here's the updated pull request for mvebu/drivers.  I've pulled the two
> patches from mvebu/soc into this branch to prevent the dependency.

Thanks for simplifying the dependencies.

> There is a trivial conflict with Sebastian's init_timer cleanup branch,
> but that would happen anyway.

Thanks, applied this version to next/drivers.

Kevin
