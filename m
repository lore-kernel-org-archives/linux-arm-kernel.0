From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2016 13:16:01 +0200
Subject: [PATCH v3 12/18] dt-bindings: Add PLX Technology OXNAS pinctrl
 and gpio bindings
In-Reply-To: <56FE984C.10807@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
 <20160325144834.GA27177@rob-hp-laptop>
 <CACRpkdbem5a_aLTHErp0ZvanwvVPbGnDiWxM5e7iX_FdHtXprQ@mail.gmail.com>
 <CAL_JsqLsKEb+dWLg9VD3p=kjgEV84_r8z89p0QgMJWKqjrGNpw@mail.gmail.com>
 <56FE8602.8020405@baylibre.com>
 <CAL_JsqJS31gNS-dYXQvkLHb=qsVz4Vccztufnd08yfD+p52v_w@mail.gmail.com>
 <56FE984C.10807@baylibre.com>
Message-ID: <CACRpkda75E+B=vsgouks4ei=jc=Q-Uj1fzQnhGR4sVJBOkMBnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 5:48 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 04/01/2016 05:19 PM, Rob Herring wrote:
>> On Fri, Apr 1, 2016 at 9:30 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>> What should I use ?
>>
>> Maybe gpio-ranges as you asked. Not really sure as I haven't used it.
>
> If I use gpio-ranges I can get rid of gpio-bank and ngpios properties.

I'm not super-happy about that but I see that it can be used
this way... hm.

Yours,
Linus Walleij
