From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 11:26:05 -0700
Subject: [PATCH] clk: tegra: add KBC clock for Tegra20
In-Reply-To: <20130122182340.24671.64241@quantum>
References: <1357946262-25823-1-git-send-email-swarren@wwwdotorg.org>
 <20130122182340.24671.64241@quantum>
Message-ID: <50FED9BD.5060907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 11:23 AM, Mike Turquette wrote:
> Quoting Stephen Warren (2013-01-11 15:17:42)
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This clock has been missing from all our upstream clock drivers. Add it
>> by copying the tegra_clk_periph_gate() call from Tegra30; the data
>> matches what's in the ChromeOS kernel for this clock.
>>
>> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
>> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Mike, I'd need to apply this to the Tegra tree as part of the common
>> clock framework conversion.
>>
> 
> Is this patch going to be rolled into patch 6/9 of the larger tegra ccf
> series?

In the latest Tegra CCF series that I posted, I've rolled all these
small fixes in already.
