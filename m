From: mporter@ti.com (Matt Porter)
Date: Wed, 27 Mar 2013 09:29:50 -0400
Subject: [PATCH 2/5] ARM: dts: AM33XX: Add default pinctrl binding for
 I2C device
In-Reply-To: <a20a6c7b5b5b45328684e5afab385ae5@DFLE51.ent.ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <a20a6c7b5b5b45328684e5afab385ae5@DFLE51.ent.ti.com>
Message-ID: <20130327132950.GI18335@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 12:59:13PM +0000, Vaibhav Hiremath wrote:
> Add pin control binding for I2C device nodes in all
> board specific DT files (as per current usage),
> 
> EVM: Both i2c0 and i2c1
> EVM-SK and Bone: Only i2c0
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Acked-by: Matt Porter <mporter@ti.com>

-Matt
