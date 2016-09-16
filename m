From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 16 Sep 2016 12:23:22 +0200
Subject: [PATCH v7 05/11] ARM: dts: koelsch: Enable UHS-I SDR-50 and
 SDR-104
In-Reply-To: <20160916100031.GH14562@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
 <1473764228-24768-6-git-send-email-horms+renesas@verge.net.au>
 <20160916100031.GH14562@verge.net.au>
Message-ID: <20160916102322.GH1411@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 12:00:32PM +0200, Simon Horman wrote:
> On Tue, Sep 13, 2016 at 12:57:02PM +0200, Simon Horman wrote:
> > Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,1,2}.
> > And the sd-uhs-sdr104 property to SDHI0.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> As SDR50 support is present in the driver in mainline (correct me if I am
> wrong!) I have queued this up after dropping the sdr104 portion and
> updating the changelog accordingly.

Looks good!

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/685f0fe7/attachment.sig>
