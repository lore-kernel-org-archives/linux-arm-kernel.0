From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Mar 2016 13:53:53 +0530
Subject: [PATCH v2 5/5] arm: davinci: remove mmc dma resources
In-Reply-To: <1457996081-21975-6-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-6-git-send-email-david@lechnology.com>
Message-ID: <56E7C699.9030107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 March 2016 04:24 AM, David Lechner wrote:
> The davinci_mmc driver no longer uses platform resources for getting dma
> channels. Instead lookup is now done using dma_slave_map.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

I guess this will now be targeted for v4.7. I can apply the patch if I
get an immutable branch from Ulf post v4.6-rc1 or if Ulf decides to
apply this, fine with me.

Acked-by: Sekhar Nori <nsekhar@ti.com>

BTW, we prefer a captialized "ARM:" in subject prefix. Whoever is
applying can probably fix it though.

Thanks,
Sekhar
