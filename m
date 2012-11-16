From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Nov 2012 13:48:01 +0900
Subject: [Patch v6 1/4] ARM: at91: atmel-ssc: add pinctrl support
In-Reply-To: <50A5A843.2060902@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
 <20121116010310.GG4387@opensource.wolfsonmicro.com>
 <50A5A843.2060902@atmel.com>
Message-ID: <20121116044758.GO4387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:43:15AM +0800, Bo Shen wrote:
> On 11/16/2012 9:03, Mark Brown wrote:

> >This generates lots of conflicts in the pinctrl stuff in the DTS - looks
> >like it was generated against -next.  Can you please regenerate against
> >my atmel branch with just the changes to add the pinmux information on
> >the SSC nodes?  Or possbily this can just be applied direct to the
> >pinctrl branch (we'll get an add/add conflict with the SSC nodes though
> >that should be simple to resolve, a cross merge might be helpful).

> As Mark suggested, would this patch be split into 2 patches? One is
> for atmel ssc add pinmux information go into ASoC tree, and the
> other add ssc node into dts file go into pinctrl tree. Would this be
> ok?

It's more of an either/or thing but the two patches would be OK, then we
can work out which to apply.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/9be1c5b7/attachment.sig>
