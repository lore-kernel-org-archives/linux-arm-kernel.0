From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Dec 2017 11:08:45 +0530
Subject: [PATCH V7 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
In-Reply-To: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20171212053845.GB18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 04:10:24PM -0500, Sinan Kaya wrote:
> Introduce new ACPI and OF device ids for thw HW along with the helper
> functions.
> 
> Changes from v6:
> * add const to the device callback parameter in fwnode.
> * reorganize the callbacks in the code
> * rename get_match_data() as device_get_match_data()
> * place pointer checks into acpi_get_match_data()

This fails for me at 3rd patch. I am on -rc1 is there a dependency?

-- 
~Vinod
