From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 13 Jan 2014 22:32:36 -0800
Subject: [PATCH 4/6] ARM: DTS: tegra: add the DFLL IP block to the T114
 SoC file
In-Reply-To: <alpine.DEB.2.02.1401132219150.11672@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123719.3226.44864.stgit@tamien> <52B389CD.8010004@wwwdotorg.org>
 <alpine.DEB.2.02.1401132219150.11672@tamien>
Message-ID: <52D4DA04.4040201@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/13/2014 10:27 PM, Paul Walmsley wrote:
> The format is <&clock-provider-phandle clock-id>.

Ah, one other change: the above string has been dropped.  Pesky examples ;-)

- Paul
