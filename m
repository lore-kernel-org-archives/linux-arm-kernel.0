From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 11 Sep 2018 15:27:22 +0200
Subject: [PATCH] arm64: dts: meson-axg: use the proper compatible for
 ethmac
In-Reply-To: <CAFBinCB2GAR7OKbiPM5DaiG-gdBvcOq7qo=97qK-Hi1LGnKQ8Q@mail.gmail.com>
References: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
 <CAFBinCB2GAR7OKbiPM5DaiG-gdBvcOq7qo=97qK-Hi1LGnKQ8Q@mail.gmail.com>
Message-ID: <49e4640e-526b-0501-1909-92743bf5fa24@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2018 20:44, Martin Blumenstingl wrote:
> On Mon, Sep 10, 2018 at 8:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Use the correct compatible for the AXG ethernet mac node.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> I wonder if you should add a "Fixes" tag. apart from that:
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 

Hi Martin,

I'm not sure when the dwmac changes has been merged, and anyway the only board upstreamed uses RGMII which has the same bits for the glue register.

Neil
