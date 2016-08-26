From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 26 Aug 2016 14:12:43 +0100
Subject: [PATCH 00/10] PM / Domains: Add support for removing PM domains
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <fd3ea080-2ec5-e22d-b0cc-8cdc4155af3c@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On 16/08/16 10:49, Jon Hunter wrote:
> In order to safely remove PM domains there are a few changes that need to be
> made to ensure that no one is holding an external reference to a PM domain
> after it has been removed. One solution, implemented here, solves this by
> eliminating external references to PM domain.
> 
> This is a follow-up to the initial RFC I sent out [0].
> 
> Changes from initial RFC:
> - Renamed functions made static per Ulf's feedback.
> - Added patch to clean-up provider/xlate APIs per Ulf's feedback
> - Re-worked and simplified the association between PM domains and PM
>   domain providers. Dropped the 'provider_data' variable from the
>   generic_pm_domain structure in favour of using the fwnode_handle.
> - Split patch for removing PM domains into multiple patches per Ulf's
>   feedback.

Let me know if you have any feedback on this. Please note I will be out
next week.

Cheers
Jon

-- 
nvpublic
