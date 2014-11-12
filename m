From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Nov 2014 15:09:52 +0530
Subject: [PATCH] DMA: Fix allocation size for PL330 data buffer depth.
In-Reply-To: <1415294412-13818-1-git-send-email-Liviu.Dudau@arm.com>
References: <1415294412-13818-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20141112093952.GD24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 05:20:12PM +0000, Liviu Dudau wrote:
> The datasheet for PL330 says that the data buffer value in the CRD
> register is 10bits wide. However, the value stored is "minus one",
> which the driver corrects for. Maximum value that the data buffer
> depth can have is 1024 lines, which requires 11 bits for storage.
> 
> While making updates I found printing the peripheral ID as a hex
> value to be more useful as the datasheet shows the values that way.

Applied, thanks

Please snure you use the right subsytem name

-- 
~Vinod
