From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jul 2015 17:23:36 +0200
Subject: [linux-sunxi] Re: [PATCH v2] mmc: sunxi: Don't start commands
 while the card is busy
In-Reply-To: <20150720080007.GR28632@lukather>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
 <20150720080007.GR28632@lukather>
Message-ID: <55AD1278.3060308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-07-15 10:00, Maxime Ripard wrote:
> Hi,
>
> On Fri, Jul 10, 2015 at 05:14:44PM +0200, Hans de Goede wrote:
>> Some sdio wifi modules have not been working reliable with the sunxi-mmc
>> host code. This turns out to be caused by it starting new commands while
>> the card signals that it is still busy processing a previous command.
>>
>> This commit fixes this, thereby fixing the wifi reliability issues on
>> the Cubietruck and other sunxi boards using sdio wifi.
>>
>> Reported-by: Eugene K <sigintmailru@gmail.com>
>> Suggested-by: Eugene K <sigintmailru@gmail.com>
>> Cc: Eugene K <sigintmailru@gmail.com>
>
> You should use the "real" name here, and not some shortening.

I don't know the real name, and AFAIK this is really only important
for S-o-b lines.

Eugene, care to share your full name with us?

Regards,

Hans
