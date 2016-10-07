From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 7 Oct 2016 04:44:46 +0300
Subject: [PATCH 1/3] nvmem: add NXP LPC18xx OTP driver
In-Reply-To: <20160913161241.22492-2-manabian@gmail.com>
References: <20160913161241.22492-1-manabian@gmail.com>
 <20160913161241.22492-2-manabian@gmail.com>
Message-ID: <8ad4d5fb-0672-fbd7-6076-a91c89dee132@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim, Srinivas,

On 13.09.2016 19:12, Joachim Eastwood wrote:
> Add simple read only driver for the internal OTP (One Time Programmable)
> memory found on all NXP LPC18xx and LPC43xx devices.
> 
> The OTP memory is split into 4 banks each with 4 32-bits word. Some of
> the banks contain predefined data while others are for general purpose
> and user programmable via the OTP API in ROM. Note that writing to the
> OTP memory is not yet supported.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---

please feel free to add my

  Tested-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
