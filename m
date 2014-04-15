From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 10:30:39 -0600
Subject: [PATCH 1/4] pinctrl: tegra: remove redundant data table fields
In-Reply-To: <534D25D1.8070202@nvidia.com>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
 <534D25D1.8070202@nvidia.com>
Message-ID: <534D5EAF.9010403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 06:28 AM, Laxman Dewangan wrote:
> On Tuesday 15 April 2014 03:03 AM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>>          u32 drvtype_bit:5;
> 
> Seems this is also need for 6.

Good catch, thanks.

I'll posted a V2 for this patch, although I won't repost patches 2..4 to
avoid re-spamming the list with the very large patch 2. Linus, I hope
that's OK.
