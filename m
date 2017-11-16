From: bp@alien8.de (Borislav Petkov)
Date: Thu, 16 Nov 2017 20:32:11 +0100
Subject: [PATCH v3 6/7] EDAC: Add missing debugfs_create_x32 wrapper
In-Reply-To: <20171110090308.21562-7-jlu@pengutronix.de>
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-7-jlu@pengutronix.de>
Message-ID: <20171116193211.be7qimab2v3jha3o@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 10:03:07AM +0100, Jan Luebbe wrote:
> We already have wrappers for x8 and x16, so add the missing x32 one.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  drivers/edac/debugfs.c     | 11 +++++++++++
>  drivers/edac/edac_module.h |  5 +++++
>  2 files changed, 16 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
