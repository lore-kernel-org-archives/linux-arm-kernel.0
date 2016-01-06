From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Jan 2016 22:20:46 +0100
Subject: [PATCH RFC 0/2] Add a display driver to the Allwinner H3
In-Reply-To: <cover.1452021349.git.moinejf@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
Message-ID: <20160106212046.GD9631@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks a lot for your work!

On Tue, Jan 05, 2016 at 08:15:49PM +0100, Jean-Francois Moine wrote:
> The proposed DRM driver works on a Orange PI 2 with a kernel 4.4-rc1
> and the H3 patches found in Hans de Goede's GIT repository.
> 
> As there is no documentation about the DE2 nor about the HDMI which
> are found in the H3, this driver has been built from Allwiiner's
> sources.

That's unfortunate :/

Have you checked in the A64 BSP if there was some useful information?

> So, there may be license problems, especially for the file
> de2_hdmi_h3.c which contains a lot of magic values.

I guess it's the biggest issue with your code right now. What licenses
issues are we talking about here?

Remember that having your Signed-off-by tag on a commit means that you
certify that you have the right to submit the patch under the license
you indicate in the files added and / or modified.

If you don't have such right, for example because you don't have the
right and / or authorization from the initial author to re-license
that code, you cannot put your SoB.

> The associated DT and documentation will be submitted when the H3 DTs
> will be in the kernel.

Having the DT binding documentation would really help in the review.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/80c37335/attachment.sig>
