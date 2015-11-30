From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 15:23:13 +0000
Subject: [Xen-devel] [PATCH v3 47/62] arm/p2m: Add helper functions to
 map memory regions
In-Reply-To: <1447753261-7552-48-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-48-git-send-email-shannon.zhao@linaro.org>
Message-ID: <565C69E1.1020705@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Create a helper function for mapping with cached attributes.

You are using those helpers to map the ACPI table in the guest. Do we
really need them to be mapped read-write?

Regards,

-- 
Julien Grall
