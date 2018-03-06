From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 6 Mar 2018 12:28:15 -0800
Subject: [PATCH v2 6/8] [PATCH 6/8] Documentation: hwmon: Add a document
 for PECI hwmon client driver
In-Reply-To: <20180221161606.32247-7-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-7-jae.hyun.yoo@linux.intel.com>
Message-ID: <0e3750a0-d45b-368d-f5cb-d2cca6797ecb@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/21/2018 08:16 AM, Jae Hyun Yoo wrote:

> +temp<n>_label		Provides DDR DIMM temperature if this label indicates
> +			'DIMM #'.
> +temp<n>_input		Provides current temperature of the DDR DIMM.
> +
> +Note:
> +	DIMM temperature group will be appeared when the client CPU's BIOS

	                       will appear when

> +	completes memory training and testing.
> 


-- 
~Randy
