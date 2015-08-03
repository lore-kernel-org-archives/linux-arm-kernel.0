From: xander.huff@ni.com (Xander Huff)
Date: Mon, 03 Aug 2015 15:18:36 -0500
Subject: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
In-Reply-To: <55B231DE.4080308@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
 <1437434050-32907-1-git-send-email-xander.huff@ni.com>
 <55B231DE.4080308@metafoo.de>
Message-ID: <55BFCC9C.5040305@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/24/2015 7:38 AM, Lars-Peter Clausen wrote:
> Hi,
>
> Sorry, but I don't think this patch has been sufficiently tested against a
> mainline kernel. The driver wont even probe the way it is right now.
>
Thanks for your responses. I'm not sure why it doesn't probe for you since I was 
able to do a fair amount of tests with it on our device.

I'll get to work on your suggestions and hopefully having a v4 out sometime next 
week.

-- 
Xander Huff
Staff Software Engineer
National Instruments
