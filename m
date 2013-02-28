From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 28 Feb 2013 21:04:15 +0100
Subject: [PATCH 1/2] ARM: Tegra: Add clock entry for smp_twd clock
In-Reply-To: <512F9F59.5030702@wwwdotorg.org>
References: <1362037381-4730-1-git-send-email-pgaikwad@nvidia.com>
 <512F9F59.5030702@wwwdotorg.org>
Message-ID: <20130228200415.GA17598@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 11:18:01AM -0700, Stephen Warren wrote:
> On 02/28/2013 12:43 AM, Prashant Gaikwad wrote:
> > As DT support for clocks and smp_twd is enabled, add clock entry
> > for smp_twd clock to DT.
> 
> Is this a cleanup for 3.10, or a bug-fix for 3.9? Perhaps it solves the
> "twd: clock not found" bug I reported?

Yes. This is pretty much identical to the patch I sent a few days ago
before your patch that fixed the clock drivers to match the devicetree
binding documentation.

The "clock not found" is exactly what this fixes.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/6b14cd82/attachment.sig>
