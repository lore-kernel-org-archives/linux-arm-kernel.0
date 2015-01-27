From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 00:11:22 +0000
Subject: [PATCH 16/18] spi/xilinx: Reset core before buffer_size detection
In-Reply-To: <1422029330-10971-17-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-17-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150127001122.GN21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:08:48PM +0100, Ricardo Ribalda Delgado wrote:
> If the core had some data on the buffer, the size detection could show
> up a smaller size than real, affecting performance.

This should've been part of your earlier patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/8297ffaa/attachment.sig>
