From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 14:32:47 +0100
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <5756C245.7010001@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
 <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk>
 <5756B22F.9000105@rock-chips.com>
 <20160607120647.GV7510@sirena.org.uk>
 <5756C245.7010001@rock-chips.com>
Message-ID: <20160607133247.GY7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 08:47:01PM +0800, Xing Zheng wrote:
> On 2016?06?07? 20:06, Mark Brown wrote:

> > OK, then the original name probably makes some sense though really
> > that's such an unusual design that just naming it after the specific
> > board might be better, it's not likely to see any reuse I'd guess.

> There are not only one type of board with this audio connection, so I think
> we don't need to add specific board name.

I imagine they're all variants on a single reference design though?  The
name is unweildy.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/5e7b555c/attachment.sig>
