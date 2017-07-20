From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 15:37:14 +0200
Subject: [PATCH 13/18] dt-bindings: vendor: Add Huarui Lighting
In-Reply-To: <CAGb2v66hWsuQQQQXJwKD-1aub_1aysQ_A9Kn2Ka5WSFMDYHN0Q@mail.gmail.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <5b7ae43738fb5ea2fb1ebebddfc75d401da94677.1499955058.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v66hWsuQQQQXJwKD-1aub_1aysQ_A9Kn2Ka5WSFMDYHN0Q@mail.gmail.com>
Message-ID: <20170720133714.nffdm5y5cxzvz65c@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Fri, Jul 14, 2017 at 03:53:40PM +0800, Chen-Yu Tsai wrote:
> On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Huarui Lighting makes display panel, add it to the list of panels.
> 
> I could not find any information on "Huarui Lighting" within the
> context of LCD panels. The company I found makes LED lighting
> fixtures, floodlights, and high power LED drivers.
> 
> This might not be a legitimate branding?

The references are sparse, but the only time I could find a vendor for
that part was here, page 51:
https://www.codico.com/shop/media/datasheets/Quectel_SC20_Hardware_Design_V1.2.pdf

But maybe it's wrong. And since it has a BPi logo on it, maybe we
should just use sinovoip as the vendor.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/dffefbbd/attachment.sig>
