From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Nov 2014 21:02:22 +0000
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <CAOesGMi5f_Kc1xA_JqiZYsbVYxaJgBXMZCe5TAxDkPQj7=o8sg@mail.gmail.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
 <CAOesGMi5f_Kc1xA_JqiZYsbVYxaJgBXMZCe5TAxDkPQj7=o8sg@mail.gmail.com>
Message-ID: <20141125210222.GO7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 12:06:41PM -0800, Olof Johansson wrote:
> On Mon, Sep 29, 2014 at 7:22 AM, Weike Chen <alvin.chen@intel.com> wrote:

> > This piece of work is derived from Dan O'Donovan's initial work for Intel Quark
> > X1000 SPI enabling.

> How about build testing for other platforms that share this driver
> when you make changes to it? This is obviously completely broken.

> Doing these constants under ifdef seems fragile at best, braindead at
> worst. Please don't proliferate that coding style.

> Mark, can you revert until Intel learns how to play well with others?

Yeah.

> This is from a pxa3xx-defconfig build:

Ugh, why does this driver not have a COMPILE_TEST dependency?  Not that
it'd have caught this one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/74a79426/attachment-0001.sig>
