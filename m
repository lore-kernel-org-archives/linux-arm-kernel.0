From: tj@kernel.org (Tejun Heo)
Date: Thu, 16 Mar 2017 17:11:21 -0400
Subject: [PATCH v2] pata: remove the at91 driver
In-Reply-To: <1489585151-16415-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489585151-16415-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170316211121.GA1480@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 02:39:11PM +0100, Boris Brezillon wrote:
> This driver is orphan since commit b2026f708e09 ("ARM: at91: remove
> at91sam9260/at91sam9g20 legacy board support"). Given that nobody cared
> adding DT support to it, it probably means it's no longer used and is
> thus a good candidate for removal.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
