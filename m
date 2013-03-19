From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 10:24:38 -0600
Subject: [GIT PULL] ARM: tegra: DT-related fixes needed by the MMC tree
In-Reply-To: <1363034651-21472-1-git-send-email-swarren@wwwdotorg.org>
References: <1363034651-21472-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51489146.9090109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 02:44 PM, Stephen Warren wrote:
> In order to convert the Tegra MMC driver to using mmc_of_parse(), some
> bugs in the Tegra device-tree content need to be fixed first; it's
> currently wrong but unused, and mmc_of_parse() causes that data to be
> used for the first time.

Chris, I don't see this pull request nor the followup patch in the
mmc-next branch yet. Are you still planning on pulling it in? Let me
know if you need me to resend them. Thanks.
