From: mporter@ti.com (Matt Porter)
Date: Wed, 27 Mar 2013 09:28:34 -0400
Subject: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match
 hardware/TRM
In-Reply-To: <686d89bc7b6d4bf1bc1c0524e4b586dd@DLEE51.ent.ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <686d89bc7b6d4bf1bc1c0524e4b586dd@DLEE51.ent.ti.com>
Message-ID: <20130327132834.GH18335@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 12:59:12PM +0000, Vaibhav Hiremath wrote:
> With DT support, where naming convention is based on base-addr
> and not id, so we should follow TRM/Spec numbering label.
> 
> This patch changes I2C numbering as per TRM, as I2C0, I2C1 and I2C2.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Acked-by: Matt Porter <mporter@ti.com>

-Matt
