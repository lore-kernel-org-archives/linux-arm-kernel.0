From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Nov 2011 22:37:14 +0000
Subject: [PATCH v2 1/2] ARM: use cache type functions for
 arch_get_unmapped_area
In-Reply-To: <1321566426-31184-1-git-send-email-robherring2@gmail.com>
References: <1321566426-31184-1-git-send-email-robherring2@gmail.com>
Message-ID: <20111117223714.GB2075@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Nov 17, 2011 at 09:47:05PM +0000, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> There are already cache type decoding functions, so use those instead
> of custom decode code which only works for ARMv6.
> 
> This change also correctly enables cache colour alignment on Cortex-A9
> whose I-cache is aliasing VIPT.

You can probably drop this paragraph.

With that,

Acked-by: Will Deacon <will.deacon@arm.com>

but yes, it would be nice to see this in -next for a bit.

Cheers,

Will
