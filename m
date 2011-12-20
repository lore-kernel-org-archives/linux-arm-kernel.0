From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Dec 2011 10:26:21 +0000
Subject: [PATCH] ARM: errata: Faulty logic in the Store Buffer may lead
 to data corruption
In-Reply-To: <4EF04971.4060406@renesas.com>
References: <4EF04923.50203@renesas.com>
 <4EF04971.4060406@renesas.com>
Message-ID: <20111220102621.GB20179@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 08:38:09AM +0000, Shinya Kuribayashi wrote:
> This is an update for the existing software workaround for the 743622
> Cortex-A9 erratum (475d92fc6e ARM: 6416/1: errata: faulty hazard checking
> in the Store Buffer may lead to data corruption).
> 
> According to the later errata notice updates, this erratum turned out
> to be present not only in (r2p0..r2p2), but in all r2p* revisions.
> Also the errata title is corrected to indicate that the errata leads to
> data corruption, and not to a processor deadlock as sometimes mentioned
> in previous revisions of the document.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
