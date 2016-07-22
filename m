From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 22 Jul 2016 12:29:22 +0100
Subject: next-20160722 build: 1 failures 5 warnings (next-20160722)
In-Reply-To: <20160722103829.GY6509@sirena.org.uk>
References: <E1bQXSf-0008Uu-Ej@optimist> <20160722103829.GY6509@sirena.org.uk>
Message-ID: <57920392.5070009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/16 11:38, Mark Brown wrote:
[...]
> DAX is explicitly disabled on
> 32 bit ARM due to problems with virtual aliasing caches (it's not clear
> to me that it shouldn't also be disabled for arm64 for the same reason).

>From ARMv7 onwards, data caches have to behave as if PIPT, so I wouldn't
expect there to be a problem for arm64.

Robin.
