From: pengw@nvidia.com (Peng Wu)
Date: Wed, 2 Jan 2013 16:11:31 -0800
Subject: [PATCH 1/2] ARM: DT: tegra: Add board level compatible properties
In-Reply-To: <50E4CB34.6070205@wwwdotorg.org>
References: <1357170831-7836-1-git-send-email-pengw@nvidia.com>
 <50E4CB34.6070205@wwwdotorg.org>
Message-ID: <50E4CCB3.2040704@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 04:05 PM, Stephen Warren wrote:
> On 01/02/2013 04:53 PM, Bryan Wu wrote:
>> The compatible properties of Tegra SoC based boards or machines need
>> to be documented. This patch adds these board levle compatible

My bad, Stephen could you please help me to fix this typo when you 
merging this patch
'levle' -> 'level'

>> properties into device tree binding document.
> This series looks reasonable now. I'll apply it tomorrow.
>
> It should be easy enough to add HDMI support; the driver is there.

OK, cool. I will take a look at this as long as driver is ready

> Do you have any idea when SATA support could be added?
Oh, do you have SATA driver merged into upstream yet?

Thanks,
-Bryan
