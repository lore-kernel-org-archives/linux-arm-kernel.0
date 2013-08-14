From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 Aug 2013 10:25:27 +0200
Subject: [PATCH V4 0/4] Add i2s support on smdk5420
In-Reply-To: <20130813124440.GX6427@sirena.org.uk>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
 <20130813124440.GX6427@sirena.org.uk>
Message-ID: <6538092.D4LPomiMyc@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 of August 2013 13:44:40 Mark Brown wrote:
> On Mon, Aug 12, 2013 at 03:19:50PM +0530, Padmavathi Venna wrote:
> > Samsung has different versions of I2S introduced in different
> > platforms. Each version has some new support added for multichannel,
> > secondary fifo, s/w reset control, internal mux for rclk src clk and
> > tdm support. Each newly added change has a quirk. So this patch adds
> > all the required quirks as driver data and based on compatible string
> > from dtsi fetches the quirks. This also adds i2s support on
> > exynos5420.
> 
> Applied all these, thanks.

Hmm, this series looks good to me too, except one thing. What about the 
bisection breakage introduced by the hole between patches 1/4 and 4/4 
(after the list of supported compatible changes in the driver and before 
respective dts files are updated)?

Best regards,
Tomasz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/8e85ba14/attachment.sig>
