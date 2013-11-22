From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Nov 2013 09:20:50 -0700
Subject: [PATCH] clk: tegra: add FUSE clock device
In-Reply-To: <20131122134140.GE26617@tbergstrom-lnx.Nvidia.com>
References: <1385001490-18927-1-git-send-email-acourbot@nvidia.com>
 <20131122134140.GE26617@tbergstrom-lnx.Nvidia.com>
Message-ID: <528F8462.4010105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 06:41 AM, Peter De Schrijver wrote:
> On Thu, Nov 21, 2013 at 03:38:10AM +0100, Alexandre Courbot wrote:
>> This clock is needed to ensure the FUSE registers can be accessed
>> without freezing the system.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Aren't you taking this patch through the clock tree?
