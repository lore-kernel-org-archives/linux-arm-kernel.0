From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Aug 2013 11:56:02 -0600
Subject: [PATCH V2 0/8] ARM: tegra: support LP1 suspend mode
In-Reply-To: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
References: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
Message-ID: <51FFE732.10703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 05:20 AM, Joseph Lo wrote:
> This series adds the support of LP1 suspend mode for Tegra.
> 
> V2:
> * double confirm each patch can be built with all the combination of
>   Tegra SoCs by bisect
> * and make sure the function is still OK with above testing

Great. I assume that at any point in the middle of this series, LP2
still works perfectly on all chips; I don't need all-or-none of the
series for LP2 to still work?
