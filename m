From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 20 Aug 2013 16:57:40 -0700
Subject: [PATCH] ARM: tegra: configure power off for Dalmore
In-Reply-To: <1376930650-6078-1-git-send-email-swarren@wwwdotorg.org> (Stephen
 Warren's message of "Mon, 19 Aug 2013 10:44:10 -0600")
References: <1376930650-6078-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87r4dnj4p7.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> From: Bill Huang <bilhuang@nvidia.com>
>
> Add DT property to tell the regulator to register pm_power_off to make
> "shutdown" work.
>
> Signed-off-by: Bill Huang <bilhuang@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> arm-soc folk,
>
> This patch showed up a little late to include in the Tegra pull requests,
> but it's simple and useful enough I'd like to see it included in v3.12 if
> possible. Could you possibly apply it to whichever branch you have/will
> apply Tegra's tegra-for-3.12-dt pull request to, after the pull request
> is applied? Thanks.

Applied to next/dt just after the Tegra DT pull request.

Thanks for the detailed explanaton.

Kevin
