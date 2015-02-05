From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Feb 2015 17:11:59 +0000
Subject: [PATCH baohua] ASoC: sirf: atlas7: atlas7_iacc_dai_ops can be
 static
In-Reply-To: <20150205170352.GA49811@snb>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
 <20150205170352.GA49811@snb>
Message-ID: <20150205171159.GY21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 01:03:52AM +0800, kbuild test robot wrote:
> sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?

This file isn't in an upstream tree, should this patch have been sent
upstream (I suspect non-upstream trees may need a bit of filtering in
the scripts)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150205/11b82af1/attachment-0001.sig>
