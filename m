From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Sep 2013 12:13:32 -0600
Subject: [PATCH 0/4] Introduce table driven initializations
In-Reply-To: <1378215105-12145-1-git-send-email-pdeschrijver@nvidia.com>
References: <1378215105-12145-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <522626CC.70804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2013 07:31 AM, Peter De Schrijver wrote:
> This patchset introduces a table driven initialization method for the
> audio, PMC and gate clocks. It's similar to the table we already have for
> the periph clocks.

I assume these patches will all go through Mike's clock tree for 3.13.

Aside from the one issue I mentioned, the series,
Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this will be followed by changes to convert the Tegra20/30
clock drivers to be table-based too?

>  2 files changed, 455 insertions(+), 550 deletions(-)

That didn't work out as much of a line-count-reduction as I had naively
hoped. Are there any more large blocks of repetitive code left to be
converted?
