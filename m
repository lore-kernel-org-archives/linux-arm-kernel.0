From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 20:34:52 +0200
Subject: [PATCH v2 07/11] ARM:stixxxx: Add STiH416 SOC support
In-Reply-To: <3733079.FxbR14kFrs@wuerfel>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com>
 <3733079.FxbR14kFrs@wuerfel>
Message-ID: <CACRpkdYmHaMhg2r4hkxoKM++_bDWug228tdjx+kiVG4h76SXVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 3:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 10 June 2013 10:27:05 Srinivas KANDAGATLA wrote:
>
>> +     soc {
>> +             pin-controller-sbc {
>> +                     #address-cells  = <1>;
>> +                     #size-cells     = <1>;
>> +                     compatible      = "st,stih416-pinctrl", "simple-bus";
>
> Why is this both its own device with a compatible string and a
> "simple-bus" at the same time? Wouldn't it be simpler to just
> scan the child device nodes from the "st,stih416-pinctrl"
> driver instead of having a separate platform_driver for them?

I think that in my comments to the pinctrl driver I had some
similar comment, so it's probably a good idea to look into
this.

Yours,
Linus Walleij
