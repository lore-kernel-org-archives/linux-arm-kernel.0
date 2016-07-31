From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 Jul 2016 16:17:24 +0200
Subject: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
In-Reply-To: <20160730151619.GR6215@lukather>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
 <20160730151619.GR6215@lukather>
Message-ID: <7d813018-49ad-c382-52ec-844f32bbad07@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30-07-16 17:16, Maxime Ripard wrote:
> On Sat, Jul 30, 2016 at 04:25:48PM +0200, Hans de Goede wrote:
>> Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
>> and newer.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> This should probably go through Ulf tree together with the rest of
> that serie to maintain the bisectability.

This going through Ulf's tree is fine with me, and indeed seems best, ack.

Regards,

Hans
