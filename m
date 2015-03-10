From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 10 Mar 2015 09:38:51 -0700
Subject: [PATCH v6 7/8] ARM: dts: enable GPIO for Broadcom Cygnus
In-Reply-To: <CACRpkdbx9h5t5QRLusnXqx31zD9W89dyvGDH4y6osK_6PeoChA@mail.gmail.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
 <1425933902-20652-8-git-send-email-rjui@broadcom.com>
 <CACRpkdbx9h5t5QRLusnXqx31zD9W89dyvGDH4y6osK_6PeoChA@mail.gmail.com>
Message-ID: <CAGVrzcZN0zUUb_zyrvijm3XBHAO+NqvrMpdptbn0oVyaShWqdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-10 3:21 GMT-07:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Mar 9, 2015 at 9:45 PM, Ray Jui <rjui@broadcom.com> wrote:
>
>> This enables all 3 GPIO controllers including the ASIU GPIO, the
>> chipcommonG GPIO, and the ALWAYS-ON GPIO, for Broadcom Cygnus SoC
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Tested-by: Dmitry Torokhov <dtor@chromium.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Pls take this through ARM SoC.

Applied to devicetree/next.
--
Florian
