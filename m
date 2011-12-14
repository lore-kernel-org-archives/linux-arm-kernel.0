From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Dec 2011 17:06:40 -0800
Subject: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
In-Reply-To: <1323439361-1647-3-git-send-email-b-cousson@ti.com> (Benoit
 Cousson's message of "Fri, 9 Dec 2011 15:02:33 +0100")
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-3-git-send-email-b-cousson@ti.com>
Message-ID: <87hb14q7vj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Add initial DT support to retrieve the frequency using a
> DT attribute instead of the pdata pointer if of_node exist.
>
> Add documentation for omap i2c controller binding.
>
> Based on original patches from Manju and Grant.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

This seems indepenent from the rest of the series, and I can queue up
for merge via the I2C tree.

Benoit, please confirm that we shouldn't have any problems if this patch
goes independently.

Grant/Rob, with your ack on the bindings, I can queue this up for the
I2C maintainers along with some other OMAP I2C changes for v3.3.

Kevin
