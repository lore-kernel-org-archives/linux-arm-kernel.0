From: broonie@kernel.org (Mark Brown)
Date: Fri, 3 May 2013 10:02:58 +0100
Subject: [PATCH v3 1/5] regulator: Introduce TI Adaptive Body Bias(ABB)
 on-chip LDO driver
In-Reply-To: <1367515215-30753-2-git-send-email-nm@ti.com>
References: <1367515215-30753-1-git-send-email-nm@ti.com>
 <1367515215-30753-2-git-send-email-nm@ti.com>
Message-ID: <20130503090258.GG4945@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 12:20:10PM -0500, Nishanth Menon wrote:
> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
> 
> Adaptive Body Biasing (ABB) modulates transistor bias voltages
> dynamically in order to optimize switching speed versus leakage.

I've applied this but please note that I still have deep concerns about
some of the discussion about controlling this from other regulators.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/b2363123/attachment-0001.sig>
