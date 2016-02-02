From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 16:52:37 -0800
Subject: [PATCH] ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard
 matrix
In-Reply-To: <2283417.UbYyfQa1E3@diego>
References: <1454121504-12683-1-git-send-email-djkurtz@chromium.org>
 <2283417.UbYyfQa1E3@diego>
Message-ID: <CAOesGMj496KKjoQ801WGbv1Z-63PnTz=24Gz8f3fBnuMSrfU3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 9:16 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Daniel,
>
> Am Samstag, 30. Januar 2016, 10:38:24 schrieb Daniel Kurtz:
>> From: James Chao <james_chao@asus.com>
>>
>> The LOCK key is at KSO9/KSI3 for Chromebook Flip and other devices
>> that use the Chrome OS EC keyboard matrix.
>>
>> Signed-off-by: James Chao <james_chao@asus.com>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
>
> that should probably be a
>         Reviewed-by: YH Huang <yh.huang@mediatek.com>
> As I don't see any actual patch handling step by him/her.
>
> Also, you might've included Olof as the keeper of all things ChromeOS when
> sending.
>
> @Olof: this seems to be pretty Veyron-specific for the moment, so I'm inclined
> to pick that up. Please holler if you disagree and want to pick it up yourself
> ;-)

Go ahead, we can take it as a fix for 4.5 at this time if you want.


-Olof
