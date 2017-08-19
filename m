From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 23:12:52 +0800
Subject: [linux-sunxi] [PATCH v5 5/8] ASoC: sun4i-i2s: Add regmap field to
 set DAI format
In-Reply-To: <20170819124839.4034-6-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
 <20170819124839.4034-6-codekipper@gmail.com>
Message-ID: <CAGb2v64d06Av8eLwN3gqXbrNPyTJMFV4EhT=65Vf=sc4cbTRrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 8:48 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs the bits to configure the operational mode are
> located in a different register. Add a regmap field so that this
> location can be configured.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
