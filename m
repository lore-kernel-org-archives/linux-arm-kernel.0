From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Jan 2012 13:32:54 +0000
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <4F1FEF55.8030604@samsung.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1FD1A5.1060305@samsung.com>
 <20120125112602.GB2991@opensource.wolfsonmicro.com>
 <4F1FEF55.8030604@samsung.com>
Message-ID: <20120125133254.GJ3687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 01:02:29PM +0100, Karol Lewandowski wrote:
> On 25.01.2012 12:26, Mark Brown wrote:

> However, I still find it little problematic that dt and non-dt
> versions behave differently when given the same set of parameters
> (previously apply_uV wasn't the default and required explicit flag).

Well, they're different things.  Device tree isn't Linux specific at
all.

> Thomas, would you mind adding small note to pmic's bindings
> documentation stating that Buck6 is basically on/off switch? (Thus,
> no voltage should nor can be specified).

At some point you end up copying the entire datasheet in there...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120125/78bbafcf/attachment.sig>
