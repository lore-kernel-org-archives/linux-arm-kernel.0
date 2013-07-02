From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Jul 2013 10:25:07 +0100
Subject: [PATCH 3/3] ARM: dts: Add WM1811A audio CODEC to Arndale bindings
In-Reply-To: <51D26360.2080708@linaro.org>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
 <1372714599-17588-3-git-send-email-broonie@kernel.org>
 <51D26360.2080708@linaro.org>
Message-ID: <20130702092507.GV27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 10:51:36AM +0530, Tushar Behera wrote:

> Arndale board also comes with two other audio codec boards - ALC5631Q
> and AK4678. Different audio codec boards came with different shipments.

This is the default though and since they didn't bother providing any
way of identifying the modules we just have to put them all in the
device tree and hope that the individual CODEC drivers can do runtime
identification (the WM1811A can but I don't know about the other two,
nobody supported them upstream).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/4a28b8a7/attachment-0001.sig>
