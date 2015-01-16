From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jan 2015 10:53:51 +0100
Subject: [PATCH v3 2/3] dt-bindings: Add pinctrl bindings for
 mt65xx/mt81xx.
In-Reply-To: <20150113161614.GF23940@pengutronix.de>
References: <1415709535-31515-1-git-send-email-hongzhou.yang@mediatek.com>
 <1415709535-31515-3-git-send-email-hongzhou.yang@mediatek.com>
 <CACRpkdYSe_BH_qiHma2BA+c2otEi3wd0TBXy83t8vwrNL+3U2g@mail.gmail.com>
 <20141127101830.GP30369@pengutronix.de>
 <CACRpkdbMdJT6y-NL36RgQe0-CAFAVGqKiwY9+yFcwA7JDLmA+Q@mail.gmail.com>
 <20141202135527.GM30369@pengutronix.de>
 <CACRpkdZeRd+j7d_iRphruHRg8p3XjqWK8_HQzLH2PTZ_pqOrYA@mail.gmail.com>
 <20150112122200.GC18908@pengutronix.de>
 <CACRpkdYXrdiRWMV8YpxrSLe2rLEV-ZnX7=36w21zGquh==6WgA@mail.gmail.com>
 <20150113161614.GF23940@pengutronix.de>
Message-ID: <CACRpkdYRrs2=gNM1XGSh1cSo5Pvx6iNLt4HjL6gdTqGPWYSRDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 5:16 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Jan 13, 2015 at 11:05:22AM +0100, Linus Walleij wrote:

>> > You often talk about ambiguities. Could you give an example what
>> > ambiguities you mean?
>>
>> What happened was this pins = ; arguments were sometimes
>> strings and sometimes integers, that becomes strange to handle
>> in code, ambiguous.
>
> I see. I like naming it 'pinmux' because that's what it is: pins and
> mux settings. A plain 'pinno' suggests that it contains only pin mubers,
> without mux setting. How about 'pin-no-mux'? We also could add an
> explicit "pins-are-numbered" property instead of distinguishing this
> by property names.

I kind of like this "pins-are-numbered" thing.

The other property for the pin, whether pinmux or pin-no-mux or
pin-num-and-mux etc is no such big deal, as long as it's
consistent and documented with the generic bindings.

Yours,
Linus Walleij
