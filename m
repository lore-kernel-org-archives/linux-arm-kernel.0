From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 12:26:31 +0200
Subject: [PATCH v7 0/3] drm: Add Support for Passive RGB to VGA bridges
In-Reply-To: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
References: <cover.60fc2fa7a6c5b5800b4e3a97b5598216817e0d9c.1476090316.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20161011102631.GU3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 11:05:40AM +0200, Maxime Ripard wrote:
> Hi,
> 
> This serie is about adding support for the RGB to VGA bridge found in
> the A13-Olinuxino and the CHIP VGA adapter.
> 
> Both these boards rely on an entirely passive bridge made out of
> resitor ladders that do not require any initialisation. The only thing
> needed is to get the timings from the screen if available (and if not,
> fall back on XGA standards), set up the display pipeline to output on
> the RGB bus with the proper timings, and you're done.
> 
> This serie also fixes a bunch of bugs uncovered when trying to
> increase the resolution, and hence the pixel clock, of our
> pipeline. It also fixes a few bugs in the DRM driver itself that went
> unnoticed before.
> 
> Let me know what you think,
> Maxime

Queued all three for 4.10.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/7305a832/attachment.sig>
