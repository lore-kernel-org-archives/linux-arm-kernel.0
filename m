From: bp@suse.de (Borislav Petkov)
Date: Wed, 1 Nov 2017 14:47:57 +0100
Subject: [RFC/RFT PATCH 4/6] ACPI / APEI: Remove ghes_ioremap_area
In-Reply-To: <20171031153832.17746-5-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-5-james.morse@arm.com>
Message-ID: <20171101134757.ivd2czbip64qulwf@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 03:38:30PM +0000, James Morse wrote:
> Now that nothing is using the ghes_ioremap_area pages, rip them out.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 39 ++-------------------------------------
>  1 file changed, 2 insertions(+), 37 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
