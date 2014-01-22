From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Jan 2014 08:25:42 +0100
Subject: [PATCH RFC v4 10/10] ahci_imx: Port to library-ised ahci_platform
In-Reply-To: <20140122065151.GC16215@pengutronix.de>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
 <1390236303-22538-11-git-send-email-hdegoede@redhat.com>
 <20140122065151.GC16215@pengutronix.de>
Message-ID: <52DF7276.5050705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/22/2014 07:51 AM, Sascha Hauer wrote:
> Hi Hans,
>
> On Mon, Jan 20, 2014 at 05:45:03PM +0100, Hans de Goede wrote:
>> This avoids the ugliness of creating a nested platform device from probe.
>>
>> Note untested, I've ordered a wandboard to be able to test these changes.
>
> Looks much better now, thanks. I could test this patch aswell, no need
> to buy new hardware for this.

Thanks for the offer, but the wandboard arrived yesterday. Having a bit more
variety in the arm hardware I've to test with is good to have anyways.

Regards,

Hans
