From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Aug 2015 17:33:04 +0100
Subject: [RESEND PATCH v1 0/1] A misjudgement should be fixed
In-Reply-To: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
References: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150825163304.GC12878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 03:52:41PM +0800, Xing Zheng wrote:
> 
> Hi,
> Being careless, judge the return value of snd_soc_card_jack_new
> is opposite, so it should be fixed.

Please don't send cover letters for single patches, if there is anything
useful it should either be in the changelog or after the --- in the
patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/08a5037f/attachment.sig>
