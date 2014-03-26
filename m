From: tj@kernel.org (Tejun Heo)
Date: Wed, 26 Mar 2014 11:42:30 -0400
Subject: [PATCH] ata: sata_highbank: remove superfluous cast
In-Reply-To: <11638294.fp3ZK6zVlg@amdc1032>
References: <11638294.fp3ZK6zVlg@amdc1032>
Message-ID: <20140326154230.GG7171@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 04:41:00PM +0100, Bartlomiej Zolnierkiewicz wrote:
> hpriv->plat_data is 'void *' so there is no need to cast it to
> 'struct ecx_plat_data *'.
> 
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.  Thanks.

-- 
tejun
