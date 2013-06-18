From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 18 Jun 2013 18:27:11 +0200
Subject: [PATCH v3 1/2] i2c: designware: use module_platform_driver
In-Reply-To: <1370918230-24793-2-git-send-email-zhangfei.gao@linaro.org>
References: <1370918230-24793-1-git-send-email-zhangfei.gao@linaro.org>
 <1370918230-24793-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130618162711.GG7718@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 10:37:09AM +0800, Zhangfei Gao wrote:
> Instead of use platform_driver_probe, use module_platform_driver
> To support deferred probing
> Also subsys_initcall may too early to auto set pinctl
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> CC: Baruch Siach <baruch@tkos.co.il>

Basically OK, but please resend for 3.12, so we get enough testing
before entering mainline. I am a bit anxious of side
effects and 3.11 is too near.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/df3973ee/attachment.sig>
