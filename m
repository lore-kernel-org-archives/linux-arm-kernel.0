From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 22 Aug 2012 11:44:27 +0300
Subject: [PATCH V6 0/6] OMAPDSS: Cleanup cpu_is checks
In-Reply-To: <cover.1345616887.git.cmahapatra@ti.com>
References: <cover.1345468541.git.cmahapatra@ti.com>
 <cover.1345616887.git.cmahapatra@ti.com>
Message-ID: <1345625067.3036.19.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-22 at 12:06 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> this patch series aims at cleaning up of DSS of cpu_is checks thereby making it
> more generic.
> 
> The 1st patch cleans up cpu_is checks from DISPC code.
> The 2nd patch removes unused functions from DSS code.
> The 3rd patch cleans up cpu_is checks from DSS code.
> The 4th patch disables VENC support on OMAP4.
> The 5th patch removes cpu_is checks from VENC code.
> The 6th patch removes cpu_is checks from DPI code and replaces it with a
> dss feature.

Thanks, looks good. I'll apply this to omapdss tree.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/ac61f56d/attachment.sig>
