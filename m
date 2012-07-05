From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 15:15:41 +0100
Subject: [V3 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <20120705142431.GD18200@sortiz-mobl>
References: <20120621101536.GR4037@opensource.wolfsonmicro.com>
 <1340278283-16423-1-git-send-email-jtzhou@marvell.com>
 <20120705142431.GD18200@sortiz-mobl>
Message-ID: <20120705141541.GO4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 04:24:31PM +0200, Samuel Ortiz wrote:
> On Thu, Jun 21, 2012 at 07:31:23PM +0800, Jett.Zhou wrote:

> > Pre-regulator of 88pm8606 is mainly for support charging based on vbus,
> > it needs to be enabled for charging battery, and will be disabled in
> > some exception condition like over-temp.

> Unless Mark already applied this patch, could you please split it into and MFD
> and a regulator (separate) patches ?

I've not applied it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/ce912973/attachment.sig>
