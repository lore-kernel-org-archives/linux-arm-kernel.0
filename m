From: ccross@android.com (Colin Cross)
Date: Wed, 15 Jun 2011 13:21:56 -0700
Subject: [PATCH 1/2] gpio/tegra: Move Tegra gpio driver to drivers/gpio
In-Reply-To: <20110615193734.23641.8004.stgit@ponder>
References: <20110615193734.23641.8004.stgit@ponder>
Message-ID: <BANLkTinij15PZw11Y3Qt=PV1kkP1pw1oaszTdMfD55Cf8cOJkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 12:37 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> As part of the gpio driver consolidation, this patch moves the Tegra driver
> into drivers/gpio
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> If there are no objections, I'll merge this via gpio/next

I have this patch as part of a series that should get posted later
this week, as well as a patch on top of it that depends on this change
and another change in my tree, but I'm pessimistic that my series will
get in to 3.1 since it depends on some common consolidation that
hasn't been agreed upon yet.  So,
Acked-by: Colin Cross <ccross@android.com>

Put it in gpio/next, and I'll make sure any other Tegra patches with
dependencies get pulled after yours.
