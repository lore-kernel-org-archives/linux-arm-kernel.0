From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Jun 2013 09:08:19 +0100
Subject: [PATCH] spi: sirf: add missed spi mode_bits that SiRFSoC
 hardware supports
In-Reply-To: <CAGsJ_4zztqXECjKJVQA955Dw=Qp3n4iFrbvQH-kd7s_4wpvvhA@mail.gmail.com>
References: <1372160729-12796-1-git-send-email-Baohua.Song@csr.com>
 <20130625154020.GG27646@sirena.org.uk>
 <CAGsJ_4zztqXECjKJVQA955Dw=Qp3n4iFrbvQH-kd7s_4wpvvhA@mail.gmail.com>
Message-ID: <20130626080819.GI27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:17:24AM +0800, Barry Song wrote:

> this was againest your for-next branch of spi as i guessed it will be
> in the coming version. you want one againest mainline?

I'm looking for things against topic/sirf.  Just checked again and it's
due to a dependency on topic/bpw.  I've merged that in and applied,
thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/4e17af80/attachment-0001.sig>
