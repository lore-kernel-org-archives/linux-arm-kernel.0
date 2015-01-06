From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 16:01:23 +0000
Subject: [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
In-Reply-To: <20150106122751.GO4194@piout.net>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106120049.GX2634@sirena.org.uk>
 <20150106122751.GO4194@piout.net>
Message-ID: <20150106160123.GA2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 01:27:51PM +0100, Alexandre Belloni wrote:
> On 06/01/2015 at 12:00:49 +0000, Mark Brown wrote :
> > On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:

> > > Atmel based boards can now only be used with device tree. Drop non DT
> > > initialization.

> > This doesn't apply against current code, please check and resend.

> It should apply after "sound: soc: atmel sam9g20_wm8731: remove useless
> include". I was based on 3.19-rc2.

So, one reason you should use subject lines matching the style for the
subsystem is that this is a big part of how people find patches to
review...  I'm not 100% sure I still have the patch, the volume is
rather high right now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/f9a1c300/attachment.sig>
