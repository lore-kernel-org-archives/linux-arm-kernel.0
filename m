From: bp@alien8.de (Borislav Petkov)
Date: Thu, 26 Apr 2018 08:08:15 +0200
Subject: [PATCH 2/3] edac: altera: Add support for Stratix10 SDRAM EDAC
In-Reply-To: <2d310ff0-fa0e-e432-ae11-ba34080b4f6e@kernel.org>
References: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
 <1524594959-5259-3-git-send-email-thor.thayer@linux.intel.com>
 <2d310ff0-fa0e-e432-ae11-ba34080b4f6e@kernel.org>
Message-ID: <20180426060815.GA7931@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 09:14:27PM -0500, Dinh Nguyen wrote:
> Does it make sense to have the support for this in separate files?

No. Per vendor or per uarch/processor type, standalone EDAC drivers are
fine. But not per the RAS capability of a functional unit.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
