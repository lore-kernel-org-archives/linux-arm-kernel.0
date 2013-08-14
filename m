From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:31:21 -0700
Subject: [PATCH 00/10] ARM: clps711x: Initial DT support / Fixes
In-Reply-To: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130814063121.GG19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:34:51PM +0400, Alexander Shiyan wrote:
> Here is next patchset for the Cirrus Logic CLPS711X target CPUs.
> The first four patches is a small fixes. The rest is a attempt
> to add DT support for this subarch.
> As long as DT support is incomplete (no peripherals), I did not
> add DTS yet. This is the next step.

Actually, an initial fragment DTS/DTSI that just adds a probe for the
machine compatible (combined with DT_MACHINE.* in the platform code)
is a great start, so don't hold back on adding DTS files/contents for
that reason.


-Olof
