From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 27 May 2015 17:39:40 +0530
Subject: [PATCH 1/3] phy-sun4i-usb: Add a sunxi specific function for
 setting squelch-detect
In-Reply-To: <20150526153816.GK26599@saruman.tx.rr.com>
References: <1427626248-6257-1-git-send-email-hdegoede@redhat.com>
 <1427626248-6257-2-git-send-email-hdegoede@redhat.com>
 <20150526153816.GK26599@saruman.tx.rr.com>
Message-ID: <5565B404.1050003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Tuesday 26 May 2015 09:08 PM, Felipe Balbi wrote:
> On Sun, Mar 29, 2015 at 12:50:46PM +0200, Hans de Goede wrote:
>> The sunxi otg phy has a bug where it wrongly detects a high speed squelch
>> when reset on the root port gets de-asserted with a lo-speed device.
>>
>> The workaround for this is to disable squelch detect before de-asserting
>> reset, and re-enabling it after the reset de-assert is done. Add a sunxi
>> specific phy function to allow the sunxi-musb glue to do this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Kishon, do you want to take this patch?

This patch should go along with the other patch in the series. So I think it's 
better you take this series along with the musb sunxi patch series.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
