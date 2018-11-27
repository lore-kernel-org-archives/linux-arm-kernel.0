From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:53:11 +0100
Subject: [PATCH v2 16/43] drm/sun4i: frontend: Move CSC bypass setup to
 format update routine
In-Reply-To: <20181123092515.2511-17-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-17-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085311.gl2rxoxw5zi6mzqg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:48AM +0100, Paul Kocialkowski wrote:
> In order to support YUV to RGB conversion with the frontend (which is
> generally used for connecting with the backend), the CSC block must not
> be bypassed.
> 
> As a result, the bit to enable CSC bypass is moved from the runtime
> resume routine to the format update routine, so that it can disabled
> when introducing support for YUV formats later.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/5f21930c/attachment.sig>
