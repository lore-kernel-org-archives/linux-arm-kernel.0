From: bp@suse.de (Borislav Petkov)
Date: Wed, 1 Nov 2017 16:30:43 +0100
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <59F9E119.6040700@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <59F9E119.6040700@arm.com>
Message-ID: <20171101153043.xgzepqbxsblmppp5@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:58:33PM +0000, James Morse wrote:
> Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?

AFAIK, the only one who has access to a reportedly somewhat working GHES
implementation is Toshi. CCed.

> ('ls /sys/firmware/acpi/tables/', if you have a HEST and EINJ we should be able
> to work something out)

That's not enough. All the EINJ boxes I have would stop accepting EINJ
writes after a couple of injections, i.e., BIOS would get "stuffed". :-)))

Maybe Tony has something better. He's already on CC.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
