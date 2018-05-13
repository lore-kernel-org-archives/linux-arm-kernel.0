From: huangtao@rock-chips.com (Tao Huang)
Date: Sun, 13 May 2018 23:18:12 +0800
Subject: [PATCH v1 11/13] dt-bindings: power: add PX30 SoCs header for
 power-domain
In-Reply-To: <508694354.7btLQf7nsA@phil>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
 <1526009672-2097-1-git-send-email-zhangqing@rock-chips.com>
 <508694354.7btLQf7nsA@phil>
Message-ID: <9c9606f0-5c97-1a6e-a3c5-f6380c16fea4@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:
On 2018?05?12? 06:11, Heiko Stuebner wrote:
> Here I have a naming question. When looking at the vendor kernel
> it looks like the px30 is largely related to the rk3326.
> (rk3326.dtsi includeing the px30.dtsi)
>
> What is the reason for basing the naming on the px30 this time? And could
> we possibly keep to rkXXXX names for the basic things in the kernel, thus
> keeping the pxXX as second name, like with the other px-variants before?
>
PX30 and RK3326 are different chips. PX30 has more features. You can simply think that RK3326 is a subset of PX30. The RK3326 is more like a PX30 derivative chip. This is not the same as the previous chips.
So we use PX30 instead of RK3326 for name, and the opening document is only for PX30, we think this is more convenient for developers.

Best Regards,
Tao Huang
