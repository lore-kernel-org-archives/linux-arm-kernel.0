From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 7 Sep 2011 11:52:43 +0200
Subject: [PATCH 17/22] OMAP2+: voltage: split out voltage processor (VP)
	code into new layer
In-Reply-To: <1314639355-12713-18-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-18-git-send-email-khilman@ti.com>
Message-ID: <CAORVsuX2HP9JO2XpPNrnBmqtJoz+en6cGPxG6n4S2c04CbHetA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> This patch is primarily a move of VP specific code from voltage.c into
> its own code in vp.c and adds prototypes to vp.h
>
> No functional changes, except debugfs...
Could be split into a specific patch, if possible.

Regards,
Jean

>
> VP debugfs moved to 'vp' subdir of <debugfs>/voltage/ and 'vp_'
> prefixes removed from all debugfs filenames.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/mach-omap2/Makefile ?| ? ?2 +-
> ?arch/arm/mach-omap2/voltage.c | ?348 +-------------------------------------
> ?arch/arm/mach-omap2/voltage.h | ? ?3 -
> ?arch/arm/mach-omap2/vp.c ? ? ?| ?374 +++++++++++++++++++++++++++++++++++++++++
> ?arch/arm/mach-omap2/vp.h ? ? ?| ? ?9 +
> ?5 files changed, 387 insertions(+), 349 deletions(-)
> ?create mode 100644 arch/arm/mach-omap2/vp.c
>
...

Regards,
Jean
