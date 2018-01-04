From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 16:50:20 +0100
Subject: [PATCH 07/11] drm/sun4i: Add support for A83T second TCON
In-Reply-To: <20171230210203.24115-8-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-8-jernej.skrabec@siol.net>
Message-ID: <20180104155020.feximenjndl6vmpd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 30, 2017 at 10:01:59PM +0100, Jernej Skrabec wrote:
> This TCON doesn't have channel 0, so quirk has_channel_0 is added in the
> process.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Ideally, this should be split in two patches, one to add the new flag,
and one to add the support for the A83t TCON-TV.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/f97ff576/attachment.sig>
