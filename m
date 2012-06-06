From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Jun 2012 11:34:11 -0600
Subject: [PATCH] ARM: tegra: Remove flow controller programming
In-Reply-To: <1338869680-8266-1-git-send-email-pgaikwad@nvidia.com>
References: <1338869680-8266-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FCF9493.2020605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2012 10:14 PM, Prashant Gaikwad wrote:
> This particular code had no effect on WFI execution. It only
> asserts/de-asserts signal to tegra "legacy" CPU idle stats
> monitor, which we are no longer using (cpufreq is based on
> kernel s/w idle stats instead).
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

Thanks, applied.
