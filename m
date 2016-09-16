From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 16 Sep 2016 12:27:10 +0200
Subject: [PATCH v7 07/11] ARM: dts: alt: Enable UHS-I SDR-50 and SDR-104
In-Reply-To: <1473764228-24768-8-git-send-email-horms+renesas@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
 <1473764228-24768-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160916102710.GJ1411@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 12:57:04PM +0200, Simon Horman wrote:
> Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,1}.
> And the sd-uhs-sdr104 property to SDHI0.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

If you drop sdr104 here for now as well:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/2907a398/attachment-0001.sig>
