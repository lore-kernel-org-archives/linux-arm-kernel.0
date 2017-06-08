From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Jun 2017 01:46:20 -0700
Subject: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
In-Reply-To: <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
Message-ID: <20170608084619.GH3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [170608 00:24]:
> If it helps, I can host a branch with the updates on the omap_hsmmc
> driver, such it can be pulled in from arm soc?

Great that works for me. Let's just make sure git bisect
keeps working.

> I guess you need that as, the DT changes relies on the new vqmmc
> binding. Or you thing it doesn't matter, because for the current
> changes that regulator is always an always on regulator?

Or maybe we can just add the new regulator, then do a
follow-up series to remove the old ones?

Regards,

Tony
