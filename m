From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 2 Jan 2018 08:36:46 -0500
Subject: [PATCH V4 25/26] i7300_idle: remove unused file
In-Reply-To: <1513661883-28662-26-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-26-git-send-email-okaya@codeaurora.org>
Message-ID: <121cd93d-562c-8ebd-21df-1dafbc525c80@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 12/19/2017 12:38 AM, Sinan Kaya wrote:
> i7300_idle.h is not being called by any source file and contains calls to
> pci_get_bus_and_slot() that we are trying to deprecate. Remove unused file.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Do you think you can pick this up?

I'll start pinging all the remaining patches.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
