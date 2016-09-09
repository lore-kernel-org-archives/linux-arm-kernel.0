From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Sep 2016 11:45:08 +0800
Subject: [PATCH] ARM: dts: sun8i: Move A23/A33 usbphy and usb_otg nodes to
 common dtsi
In-Reply-To: <20160908202320.GU8913@lukather>
References: <20160908032535.12987-1-wens@csie.org>
 <20160908202320.GU8913@lukather>
Message-ID: <CAGb2v65T-x2EZFuFAX2LW=qC8Fv-EnweQf2vVugGmoCZyppDPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 4:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Sep 08, 2016 at 11:25:35AM +0800, Chen-Yu Tsai wrote:
>> The usbphy and usb_otg nodes in the A23 and A33 dts files only differ
>> by compatible, and for the usbphy, the size of one of its register
>> regions.
>>
>> Move all the common bits to the A23/A33 common dtsi file.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> Hi Maxime,
>>
>> This patch applies on top of your A23/A33 CCU patches.
>
> It was not applying properly. I think I did the proper fixup, but
> you'll probably want to double check.

Looks correct. Thanks for the fixup.

ChenYu
