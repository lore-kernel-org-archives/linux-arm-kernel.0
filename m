From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Oct 2013 10:47:08 +0100
Subject: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82866807@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
 <20131018173126.GU2443@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82866807@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131022094708.GA2883@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:24:56AM +0000, Xiubo Li-B47053 wrote:

> Yes, the "-- SGTL5000 pins:" should be in the CODEC binding.
> But, actually the CODEC binding hasn't any reference about this.

> So I added it here, but not very sure.

Please add them to the CODEC binding instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/be7f6f88/attachment-0001.sig>
