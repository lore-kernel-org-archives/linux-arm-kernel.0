From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 13:59:25 -0800
Subject: [PATCH v3 00/10] Add tegra30 support for secondary cores
In-Reply-To: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120226215925.GD11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 01:47:40AM +0200, Peter De Schrijver wrote:
> This patchset introduces support for secondary cores on tegra30. It also
> introduces some functions for the flowcontroller and adds basic support for
> tegra30 powerdomains.

Thanks, I've applied this series in a new for-3.4/t3-smp branch: It depends and
pulls in both for-3.4/soc and for-3.4/soc-drivers, but I didn't want to just
add it on top of soc-drivers on the same topic.

I added the comment to headsmp.S that Colin had a nit about, besides that it
was just a couple of minor trivial context conflicts that I fixed up.

Please follow up with separate patches for the shutdown issues, etc.


Thanks!


-Olof
