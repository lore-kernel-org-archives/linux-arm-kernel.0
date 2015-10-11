From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Oct 2015 11:49:39 +0200
Subject: [linux-sunxi] Re: [PATCH v2 resend 0/4] ARM: dts: sunxi: q8 A13
 tablet backlight support
In-Reply-To: <20151001203331.GP7104@lukather>
References: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
 <20151001203331.GP7104@lukather>
Message-ID: <561A30B3.8060106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-10-15 22:33, Maxime Ripard wrote:
> Hi,
>
> On Tue, Sep 29, 2015 at 12:29:47PM +0200, Hans de Goede wrote:
>> Hi Maxime,
>>
>> This series seems to have fallen through the cracks, hence this
>> resend.
>
> No, it didn't fall through the cracks, I asked a question on the first
> patch and never got a reply.
>
> The way we handled *all* the controllers so far is that the compatible
> was representing what the controllers what features the controller was
> exposing. This is the case for the clocks or pinctrl for example.
>
> We should be consistent with that (beside the fact that using a
> compatible from a later SoC is wrong).

Ah ok, I somehow missed that reply, a pwm patch to add the compatibles
+ v3 of the dts patches is coming up.

Regards,

Hans
