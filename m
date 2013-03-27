From: mporter@ti.com (Matt Porter)
Date: Wed, 27 Mar 2013 10:11:55 -0400
Subject: [PATCH 3/5] ARM: dts: AM33XX: Fix gpio numbering to match
 hardware/TRM
In-Reply-To: <1364389156-8273-4-git-send-email-hvaibhav@ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <1364389156-8273-4-git-send-email-hvaibhav@ti.com>
Message-ID: <20130327141155.GK18335@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 06:29:14PM +0530, Vaibhav Hiremath wrote:
> With DT support, where naming convention is based on base-addr
> and not id, so we should follow TRM/Spec numbering label.
> 
> This patch changes GPIO numbering as per TRM, as gpio0-3.
> 
> Matt Porter had submitted base patch sometime back but it
> didn't make it to the mainline -
> https://patchwork.kernel.org/patch/1433001/
>
> Later DT nodes for gpio based keypad and led driver got
> merged, so this fix needs to propagate to board dts files
> as well.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Matt Porter <mporter@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Thanks for picking this up, Vaibhav. It'll eliminate all
the pain people have with the DT not matching the TRM.

-Matt
