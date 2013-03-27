From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 27 Mar 2013 14:22:22 +0100
Subject: [PATCH 1/5] ARM: dts: AM33XX: Fix the i2c numbering to match
 hardware/TRM
In-Reply-To: <1364389156-8273-2-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Wed, 27 Mar 2013 18:29:12 +0530")
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <1364389156-8273-2-git-send-email-hvaibhav@ti.com>
Message-ID: <87k3ot6kq9.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> With DT support, where naming convention is based on base-addr
 Vaibhav> and not id, so we should follow TRM/Spec numbering label.

 Vaibhav> This patch changes I2C numbering as per TRM, as I2C0, I2C1 and I2C2.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

What about the uart numbers while we're at it?

-- 
Bye, Peter Korsgaard
