From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Jun 2014 09:53:18 -0600
Subject: [PATCH v2] clk: tegra124: init table updates
In-Reply-To: <1403796403-26443-1-git-send-email-pdeschrijver@nvidia.com>
References: <1403796403-26443-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53AC41EE.7090103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2014 09:26 AM, Peter De Schrijver wrote:
> Ensure some clocks critical for system operation are always on. Also enable
> csite for JTAG debugging and set the tsensor clock frequency for the upcoming
> soctherm driver.

Acked-by: Stephen Warren <swarren@nvidia.com>
