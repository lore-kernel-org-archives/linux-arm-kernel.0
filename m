From: stigge@antcom.de (Roland Stigge)
Date: Mon, 16 Apr 2012 18:12:12 +0200
Subject: [PATCH v2 1/3] USB: Add driver for NXP ISP1301 USB transceiver
In-Reply-To: <Pine.LNX.4.44L0.1204161201480.1408-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1204161201480.1408-100000@iolanthe.rowland.org>
Message-ID: <4F8C44DC.7030702@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 06:02 PM, Alan Stern wrote:
>> Maybe one of (new):
>>
>>     drivers/usb/transceiver/
>>     drivers/usb/phy/
>>     drivers/usb/lowlevel/
>>
>> ?
>>
>> Otherwise, I will put it in drivers/usb/otg/ even of it doesn't look
>> better to me but the chip is advertised as "OTG transceiver". ;-)
> 
> I don't know.  Maybe Greg KH or Felipe Balbi will have a
> recommendation.  But any of these alternatives would be better than
> drivers/usb/misc/.

Since you and Greg-KH seem to be fine with the above, I'll pick
drivers/usb/phy/ for now.

Thanks for your fast responses,

Roland
