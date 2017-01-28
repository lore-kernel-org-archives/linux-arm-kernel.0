From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 28 Jan 2017 20:46:39 +0800
Subject: [PATCH v2 8/9] ASoC: sunxi: allow the analog codec driver to be
 built on ARM64
In-Reply-To: <20170127200532.pemk36hwyzkun3i5@lukather>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-9-icenowy@aosc.xyz>
 <20170127200532.pemk36hwyzkun3i5@lukather>
Message-ID: <CAGb2v669B=uYO4HkdHJ=3LdoGEWJxO8y+kmA+X35LYnuDqWL1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 4:05 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jan 26, 2017 at 11:48:58PM +0800, Icenowy Zheng wrote:
>> As the 64-bit Allwinner H5 SoC has the same analog codec part (also the
>> same digital part) as H3, enable the driver to be built on ARM64
>> Allwinner platform, so that it can be used on H5.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
