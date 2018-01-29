From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jan 2018 11:32:48 +0000
Subject: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add set_tdm_slot
 functionality
In-Reply-To: <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
Message-ID: <20180129113248.GA10969@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 08:34:00AM +0100, Code Kipper wrote:

> I'm not sure..I was looking for a clean example of being able to
> override the number of bclks in the lrclk width and some other
> devices(Rpi) were doing it this way.  I open to suggestions,

You're looking for set_bclk_ratio() I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/2569891e/attachment.sig>
