From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 14:52:54 +0200
Subject: [PATCH v2 4/9] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <20161019121614.3crr76qyexhamjiy@lukather>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <d707c657502b87a7f8e70c7b44492bc95939f9f6.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64gBi71W=+Tu2vz94xFDtuRNHUyVWK3ken8CSOWvK5t0g@mail.gmail.com>
 <20161019121614.3crr76qyexhamjiy@lukather>
Message-ID: <CACRpkdY3+OnQ6Oo_nx+BrWebeTa=kYhHWSzirk1MxfWWJ--0Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 2:16 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Oct 18, 2016 at 03:47:03PM +0800, Chen-Yu Tsai wrote:
>> > @@ -342,6 +365,8 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
>> >                                     struct pinctrl_map *map,
>> >                                     unsigned num_maps)
>> >  {
>> > +       unsigned long *pinconfig;
>>
>> This looks out of place and context?
>
> Yeah, sorry, it's just a leftover from the previous version. This has
> been removed.

Do you mean you will send a v3 of this series?

OK stopping to apply then.

But I have already applied patches 1, 2 and 3 so just resend the rest :)

Yours,
Linus Walleij
