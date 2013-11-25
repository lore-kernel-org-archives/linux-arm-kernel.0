From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Nov 2013 15:37:33 +0000
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
Message-ID: <20131125153733.GE14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:26:53AM -0200, Fabio Estevam wrote:

> linux-next 20131120: backlight fails
> linux-next 20131122: backlight works
> linux-next 20131125: backlight fails

What are the differences between those kernels?  I'm not aware of any
regulator core changes at all there and diff isn't showing me any - are
you sure you used a consistent kernel configuration?  Have you tried to
look at what happens when we should provide the dummy regulator, and do
the logs say anything?

> Looks like we need to apply this one to make sure backlight works:
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/281826

Please always provide plain text versions of links and SHA1s...  that
link is to a patch adding a fixed regulator which you should do but
ought not to need to do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/dd9cf2a7/attachment-0001.sig>
