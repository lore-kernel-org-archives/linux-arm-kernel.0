From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 16:37:45 +0800
Subject: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
In-Reply-To: <20180711083036.7attjq4hm5ay5gmn@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180711083036.7attjq4hm5ay5gmn@flea>
Message-ID: <CAGb2v64wpL11phjM0u05rSSh5QPrxEnoZc6nxmK51EBCGSV3mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 4:30 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
>> This series fixes several issues found in R40 HDMI patch series after
>> it was applied. Conversation can be found here:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.html
>>
>> Patches are based on latest linux-next (next-20180710) and are ordered
>> in such way that they don't break R40 HDMI at any time. Because of that
>> I suggest that whole series goes through drm-misc to preserve that order.
>>
>> I also tested those patches on H3 to make sure it doesn't break other
>> platforms. However, it would be nice to test for regressions also on
>> older SoCs (with DE1).
>>
>> Best regards,
>> Jernej
>
> Applied all patches but the patch 10, thanks!

Patch 4 actually has an error. Hope you haven't pushed it out yet.

ChenYu
