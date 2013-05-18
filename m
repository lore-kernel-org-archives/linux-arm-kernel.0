From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 May 2013 12:25:05 +0100
Subject: [alsa-devel] [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
In-Reply-To: <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
 <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
Message-ID: <20130518112505.GS1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 07:03:24PM +0800, Barry Song wrote:
> 2013/5/17 Mark Brown <broonie@kernel.org>:

> > Otherwise this looks OK for ASoC though I'd expect to see a change to
> > registration of the OpenMoko BT device (perhaps I missed it though).

> sorry. i don't understand. i would think OpenMOKO can also use this driver?

If you change the names the driver uses to bind you need to also update
the users so that they use the new name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130518/d3ff59fa/attachment.sig>
