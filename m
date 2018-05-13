From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 13 May 2018 22:53:00 +0200
Subject: [PATCH v1 11/13] dt-bindings: power: add PX30 SoCs header for
 power-domain
In-Reply-To: <9c9606f0-5c97-1a6e-a3c5-f6380c16fea4@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
 <508694354.7btLQf7nsA@phil>
 <9c9606f0-5c97-1a6e-a3c5-f6380c16fea4@rock-chips.com>
Message-ID: <1550439.0mAU4944n0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Sonntag, 13. Mai 2018, 17:18:12 CEST schrieb Tao Huang:
> Hi Heiko:
> 
> On 2018?05?12? 06:11, Heiko Stuebner wrote:
> > Here I have a naming question. When looking at the vendor kernel
> > it looks like the px30 is largely related to the rk3326.
> > (rk3326.dtsi includeing the px30.dtsi)
> > 
> > What is the reason for basing the naming on the px30 this time? And could
> > we possibly keep to rkXXXX names for the basic things in the kernel, thus
> > keeping the pxXX as second name, like with the other px-variants before?
> 
> PX30 and RK3326 are different chips. PX30 has more features. You can simply
> think that RK3326 is a subset of PX30. The RK3326 is more like a PX30
> derivative chip. This is not the same as the previous chips. So we use PX30
> instead of RK3326 for name, and the opening document is only for PX30, we
> think this is more convenient for developers.

ok, sounds reasonable :-) ... So we'll stay with the PX30.


Heiko
