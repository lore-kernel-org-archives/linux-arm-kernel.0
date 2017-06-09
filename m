From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 9 Jun 2017 13:01:25 +0200
Subject: [PATCH v2] gpio: mvebu: fix regmap_update_bits usage
In-Reply-To: <20170609100917.26660-1-gregory.clement@free-electrons.com>
References: <20170609100917.26660-1-gregory.clement@free-electrons.com>
Message-ID: <20170609130125.43b8258f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri,  9 Jun 2017 12:09:17 +0200, Gregory CLEMENT wrote:
> In some place in the driver regmap_update_bits was misused. Indeed the
> last argument is not the value of the bit (or group of bits) itself but
> the mask value inside the register.
> 
> So when setting the bit N, then the value must be BIT(N) and not 1.
> 
> CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> CC: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks for fixing this so quickly!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
