From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 13:43:38 -0600
Subject: [PATCH v3 00/19] Introduce common infra for tegra clocks
In-Reply-To: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D9AEA.3080009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> This patchset introduces common infrastructure for clocks which exist in                                                                                       
> several Tegra SoCs. We also also move Tegra20, Tegra30 and Tegra114 to
> this new infrastructure.

Overall, this series looks reasonable aside from the few nits I pointed
out. I'll hold my ack until the issues I found during testing are
resolved though.
