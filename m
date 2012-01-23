From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jan 2012 19:33:00 +0000
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <4F1DB34C.4030103@gmail.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1D9DDE.2070106@samsung.com>
 <20120123182056.GA26409@opensource.wolfsonmicro.com>
 <4F1DB34C.4030103@gmail.com>
Message-ID: <20120123193259.GC26409@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 08:21:48PM +0100, Karol Lewandowski wrote:
> On 01/23/2012 07:20 PM, Mark Brown wrote:

> >Documentation/SubmittingPatches please...

> I should have stated explicitly that purpose of this patch (I should
> have called it sniplet) was to show my point only.

> IMHO it's still up to debate how above problem should be solved.

It looks like a reasonable solution to me, and it wouldn't conflict with
any better solution that does come along.

> I'm not entirely sure that we really need things like e.g. "EN32KHz
> AP" in DT (nor in platform data, for that matter).  I would like to
> see Thomas' opinion first.

The 32kHz crystals are a bit of an odd case, really those should be
handled by the clock API but obviously that's stalled and has been for
quite some time.
