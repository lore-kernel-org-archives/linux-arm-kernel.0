From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 15:43:47 +0100
Subject: [PATCH v4 16/19] arm64: GICv3: introduce symbolic names for
 GICv3 ICC_SGI1R_EL1 fields
In-Reply-To: <1415959683-26027-17-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-17-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123144347.GC3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:08:00AM +0000, Andre Przywara wrote:
> The gic_send_sgi() function used hardcoded bit shift values to
> generate the ICC_SGI1R_EL1 register value.
> Replace this with symbolic names to allow reusing them later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
