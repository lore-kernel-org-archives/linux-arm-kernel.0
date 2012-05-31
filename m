From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 May 2012 14:11:06 +0100
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <4FC76D29.8070802@ti.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
 <4FC768F8.4050406@ti.com> <20120531130456.GB15786@sirena.org.uk>
 <4FC76D29.8070802@ti.com>
Message-ID: <20120531131106.GF2666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 03:07:53PM +0200, Cousson, Benoit wrote:
> On 5/31/2012 3:04 PM, Mark Brown wrote:
> >On Thu, May 31, 2012 at 02:50:00PM +0200, Cousson, Benoit wrote:

> >>It looks to me that this kind of function does belong to the device
> >>more than to the clock node.

> >This is looking a lot like what power domains do to me...

> Do you mean the reset part?

Yes, the general "this block goes into an idle state and so we need to
rebuild/reset the state of the things in it afterwards" thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/8a7de937/attachment.sig>
