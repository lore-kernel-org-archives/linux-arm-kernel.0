From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 19 Jan 2011 06:39:43 +0530
Subject: ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248473C06@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudhakar,

On Tue, Jan 18, 2011 at 10:13:14, Rajashekhara, Sudhakar wrote:

> I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
> at [1] and found that audio is broken. Below patch fixes the issue.

[...]

> I am currently debugging this issue. I'll submit the above patch to community
> once the issue of fixed.

When posting the formal patch please don't forget:

Cc: stable at kernel.org  [2.6.37]

Thanks,
Sekhar
