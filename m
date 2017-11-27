From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 27 Nov 2017 17:44:06 +0530
Subject: [PATCH 1/2] ARM: davinci: make the function argument as const
In-Reply-To: <1508148504-2771-2-git-send-email-bhumirks@gmail.com>
References: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
 <1508148504-2771-2-git-send-email-bhumirks@gmail.com>
Message-ID: <0f817e2b-2251-7473-a60b-46ff66c0e77e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 October 2017 03:38 PM, Bhumika Goyal wrote:
> Make the function argument of the function davinci_common_init
> as const as it's memory contents are only copied during a
> memcpy call. So, the fields of the structure to which the argument
> soc_info points to never gets modified and therefore the argument can
> be made const.
> Add const to the prototype too.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

The subject line is written too generically. I changed that to

"
ARM: davinci: make argument to davinci_common_init() as const
"

while applying to v4.16/fixes-non-critical

Thanks,
Sekhar
