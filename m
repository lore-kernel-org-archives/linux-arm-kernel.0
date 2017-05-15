From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 15 May 2017 14:30:00 +0200
Subject: [PATCH v2 0/2] plug KVM ARMv7 debug leakage
In-Reply-To: <20170511124612.11212-1-alex.bennee@linaro.org>
References: <20170511124612.11212-1-alex.bennee@linaro.org>
Message-ID: <20170515123000.GB18755@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 01:46:10PM +0100, Alex Benn?e wrote:
> Hi,
> 
> This is pretty much v1 + comments from Marc and a minor re-factor of
> the trap path to make it cleaner w.r.t. cp14/cp15 trapping.

Thanks for these.

I've applied them to kvmarm/master and cc'ed the first one to stable.

-Christoffer
