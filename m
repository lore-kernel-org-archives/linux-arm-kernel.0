From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Sep 2016 23:20:39 +0800
Subject: [PATCH 1/4] drm/sun4i: rgb: Declare RGB encoder and connector as
 MIPI DPI
In-Reply-To: <20160918191205.GG17518@lukather>
References: <20160915151402.15992-1-wens@csie.org>
 <20160915151402.15992-2-wens@csie.org>
 <20160918191205.GG17518@lukather>
Message-ID: <CAGb2v65ueTf9GZYS_3h15jm9SSA4LjNg11m24kxb4Cz92xZb2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 3:12 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Sep 15, 2016 at 11:13:59PM +0800, Chen-Yu Tsai wrote:
>> The 18 or 24 bit parallel RGB LCD panel interface found on Allwinner
>> SoCs matches the description of MIPI DPI. Declare the RGB encoder and
>> connector as MIPI DPI.
>
> Unfortunately, even it that patch might be true (is there a public
> spec for that standard?), this breaks the user-space, so there's no

Not that I know of. I basically googled the term and looked at other
datasheets and asked on #linux-arm-kernel.

> way we change this.

:(

ChenYu
