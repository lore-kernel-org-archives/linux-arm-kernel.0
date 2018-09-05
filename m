From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 5 Sep 2018 13:54:42 +0530
Subject: [PATCH v4 4/4] drm/sun4i: Enable DesignWare HDMI for SUN50I
In-Reply-To: <20180905070819.gisznpkvvuqire7c@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-4-jagan@amarulasolutions.com>
 <20180905070819.gisznpkvvuqire7c@flea>
Message-ID: <CAMty3ZAzjSwq86BwB8O_7DrT0jrhn3ByzN34dY37pF3ZsAZ6uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 12:38 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Sep 04, 2018 at 10:06:09PM +0530, Jagan Teki wrote:
>> Allwinner SUN50I are now using DesignWare HDMI so enable
>> them as default. This can build DRM_SUN8I_DW_HDMI as module
>> since DRM in arm64 has module.
>>
>> Making this as defult to SUN8I, may cause an issue while
>> loading since arm32 DRM built as static.
>
> Uh? Why? We should fix this instead of working around it.

I didn't dig further on this. Since ARM64 has is fine with it both
(module and static) may be we can take this.
