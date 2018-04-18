From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Apr 2018 10:09:03 -0700
Subject: [PATCH] ARM: omap2: Fix build when using split object directories
In-Reply-To: <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
References: <20180411211543.7923-1-d-gerlach@ti.com>
 <20180412082157.GB4002@localhost.localdomain>
 <CAK7LNAQiq-4daX2K4dPyzN7zr+yfkQWSJ-yy9JHgacPpYFp94w@mail.gmail.com>
 <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
Message-ID: <20180418170903.GG5671@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [180413 14:08]:
> This is the version of this patch that we want to use, will this go through you?

Sorry for the delay, I just noticed this. Somehow I thought Santosh
would queue it, but as the regression was introduced by a commit in
my tree I'll pick this patch into omap-for-v4.17/fixes.

Thanks,

Tony
