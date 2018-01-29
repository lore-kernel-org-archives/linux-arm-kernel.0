From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jan 2018 12:31:04 +0000
Subject: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add set_tdm_slot
 functionality
In-Reply-To: <CAEKpxBnHEW+uN0yJOCaBODY2p_uxOcu7+ofsRuutrwvbJ9KeCA@mail.gmail.com>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
 <20180129113248.GA10969@sirena.org.uk>
 <CAEKpxBnHEW+uN0yJOCaBODY2p_uxOcu7+ofsRuutrwvbJ9KeCA@mail.gmail.com>
Message-ID: <20180129123104.GB10969@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 01:28:51PM +0100, Code Kipper wrote:
> On 29 January 2018 at 12:32, Mark Brown <broonie@kernel.org> wrote:

> > You're looking for set_bclk_ratio() I think.

> I'm looking for a mechanism to be able to override the bclk width
> (usually it's based on param_width) from the device tree. The tdm slot
> functionality looked just what I needed.

The simple and graph cards have support for bclk ratio configuration as
well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/8f285866/attachment.sig>
