From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 11:41:42 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <CACRpkdbj_shuGWATGER+zxvA9MNDobGjWC3XHh+-5e0R6V4n4w@mail.gmail.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
 <20120401212750.GE8971@opensource.wolfsonmicro.com>
 <CACRpkdbj_shuGWATGER+zxvA9MNDobGjWC3XHh+-5e0R6V4n4w@mail.gmail.com>
Message-ID: <20120402104142.GB3172@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 12:33:20AM +0200, Linus Walleij wrote:

> Yeah ... but this sounds familiar, (searching searching) Yes! We did ask on
> the lists if regulators were proper for modeling power domains in 2008:
> http://marc.info/?l=linux-arm-kernel&m=121580531500758&w=2

> But I should've pushed for a proper answer ...

It's not unreasonable to use regulators to model the domains (or as part
of modelling the domains, I'd imagine some systems will be able to do
things to regulators as a result of power domain actions).  So long as
the hookup which might affect other systems is done from SoC specific
code and doesn't impact other systems) there shouldn't be an issue from
a framework point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/1de9c0c8/attachment.sig>
