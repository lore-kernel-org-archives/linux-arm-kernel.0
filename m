From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Sep 2014 01:22:10 +0200
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917160508.GA2464@xora-yoga-13>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org> <20140917160508.GA2464@xora-yoga-13>
Message-ID: <201409180122.10631.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 September 2014, Graeme Gregory wrote:
> It sounds like from the discussions in other threads that ARM64 should
> be following x86 and re-using DT bindings here. In which case there is
> not need to submit things to UEFI organisation.
> 
> What I got a little lost in has there been a formal decision about DT
> bindings in _DSD?

I think this is a discussion that still needs to happen: either we should
recommend everyone to use _DSD in favor of the alternatives, or we
should prohibit the use of _DSD. I have heard arguments both ways, but
hopefully we can find an easy answer.

	Arnd
