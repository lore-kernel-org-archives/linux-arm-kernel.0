From: wni@nvidia.com (Wei Ni)
Date: Tue, 19 Feb 2013 17:48:06 +0800
Subject: [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
In-Reply-To: <1B93E76B0D8B0E4E8BDD54060BBDE81975FB926ACC@HQMAIL03.nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-3-git-send-email-wni@nvidia.com>
 <1B93E76B0D8B0E4E8BDD54060BBDE81975FB926ACC@HQMAIL03.nvidia.com>
Message-ID: <51234A56.4020006@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 06:29 AM, Matthew Longnecker wrote:
> Wei,
> 
> This set of patches seems to include 3 logical subsets
> 1) lm90 changes
> 2) dt support in drivers/thermal
> 3) tegra30 support in drivers/thermal
> 
> Would it make sense to split this into 3 separate sets of changes?

Ok, I will do it in my next version.

> 
> -Matt Longnecker
> 
> nvpublic
> 
