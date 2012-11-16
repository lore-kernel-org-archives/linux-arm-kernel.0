From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Nov 2012 10:03:11 +0900
Subject: [Patch v6 1/4] ARM: at91: atmel-ssc: add pinctrl support
In-Reply-To: <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121116010310.GG4387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 06:09:08PM +0800, Bo Shen wrote:
> Add pinctrl support for atmel ssc peripheral
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

This generates lots of conflicts in the pinctrl stuff in the DTS - looks
like it was generated against -next.  Can you please regenerate against
my atmel branch with just the changes to add the pinmux information on
the SSC nodes?  Or possbily this can just be applied direct to the
pinctrl branch (we'll get an add/add conflict with the SSC nodes though
that should be simple to resolve, a cross merge might be helpful).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/c118b45c/attachment.sig>
