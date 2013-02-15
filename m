From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Feb 2013 09:43:49 -0700
Subject: [v3 5/6] ARM: tegra114: create a DT header defining CLK IDs
In-Reply-To: <1360917814-27236-6-git-send-email-hdoyu@nvidia.com>
References: <1360917814-27236-1-git-send-email-hdoyu@nvidia.com>
 <1360917814-27236-6-git-send-email-hdoyu@nvidia.com>
Message-ID: <511E65C5.7050107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2013 01:43 AM, Hiroshi Doyu wrote:
> To replace magic number in tegra_car:
> 
> -               clocks = <&tegra_car 28>;
> +               clocks = <&tegra_car CLK_HOST1X>;

Since the Tegra114-related files don't actually exist yet and hence
can't be applied, I think Peter should roll these patches into his
Tegra114 CCF series.

But perhaps hold off on that until Grant has a chance to ack/nak the
concept of doing this, and we've finalized on include path settings
etc., so there's no churn.
