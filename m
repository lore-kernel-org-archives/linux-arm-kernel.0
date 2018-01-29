From: codekipper@gmail.com (Code Kipper)
Date: Mon, 29 Jan 2018 13:28:51 +0100
Subject: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add set_tdm_slot
 functionality
In-Reply-To: <20180129113248.GA10969@sirena.org.uk>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
 <20180129113248.GA10969@sirena.org.uk>
Message-ID: <CAEKpxBnHEW+uN0yJOCaBODY2p_uxOcu7+ofsRuutrwvbJ9KeCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2018 at 12:32, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jan 29, 2018 at 08:34:00AM +0100, Code Kipper wrote:
>
>> I'm not sure..I was looking for a clean example of being able to
>> override the number of bclks in the lrclk width and some other
>> devices(Rpi) were doing it this way.  I open to suggestions,
>
> You're looking for set_bclk_ratio() I think.
Hi Mark,
I'm looking for a mechanism to be able to override the bclk width
(usually it's based on param_width) from the device tree. The tdm slot
functionality looked just what I needed.
BR,
CK
