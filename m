From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Apr 2016 19:56:08 +0100
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <CAOesGMiqpm1TjiOpCv+kYp60FrhRhs3Leomv5KyySk8k15YFNw@mail.gmail.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
 <CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
 <20160414182520.GA8663@sirena.org.uk>
 <CAOesGMiqpm1TjiOpCv+kYp60FrhRhs3Leomv5KyySk8k15YFNw@mail.gmail.com>
Message-ID: <20160414185608.GB8663@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 11:49:11AM -0700, Olof Johansson wrote:

> So, to clarify: a follow-up patch (to arm at kernel.org) to turn on ACPI
> in arm64 defconfig, and a respin of this patch to change the default.

Yes.  Well, I actually had and additional patch to change the default to
be y only for x86 and IA-64 separately to this one remove the EXPERT
dependency but that's just bikeshedding.  Will send tomorrow unless
there's other comments.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/234f4630/attachment.sig>
