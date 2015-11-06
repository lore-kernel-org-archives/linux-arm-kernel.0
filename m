From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Nov 2015 09:28:42 +0000
Subject: [PATCH v2 1/2] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <563C61A9.2080105@rock-chips.com>
References: <1446717194-8572-1-git-send-email-zhengsq@rock-chips.com>
 <1446717194-8572-2-git-send-email-zhengsq@rock-chips.com>
 <20151105161311.GR18409@sirena.org.uk>
 <563C61A9.2080105@rock-chips.com>
Message-ID: <20151106092842.GT18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:15:37PM +0800, Shunqian Zheng wrote:
> On 2015?11?06? 00:13, Mark Brown wrote:
> >On Thu, Nov 05, 2015 at 05:53:13PM +0800, Shunqian Zheng wrote:

> >This looks like a simple boolean control rather than an enum - it looks
> >like it's just turning antipop on and off.

> It is a boolean control, but it takes 2 bits -- the value of "on" is b10 and
> b01 for "off".
> So I try to use VALUE_ENUM.

The presentation of the control to userspace needs to be a Switch, this
is probably going to need you to code something custom.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/d744852d/attachment.sig>
