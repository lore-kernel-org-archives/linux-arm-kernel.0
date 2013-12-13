From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 13 Dec 2013 11:45:10 -0700
Subject: [PATCH V1 06/11] ARM: dts: imx6qdl-sabrelite: add gpio-keys
In-Reply-To: <201312131251.13852.marex@denx.de>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-7-git-send-email-troy.kisky@boundarydevices.com>
 <201312131251.13852.marex@denx.de>
Message-ID: <52AB55B6.7080104@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 4:51 AM, Marek Vasut wrote:
> On Friday, December 13, 2013 at 02:49:10 AM, Troy Kisky wrote:
>> Add power, menu, home, back, volume up, and volume down
>> buttons.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Are these really present on the board or are they on some expansion board? I am
> not sure how to handle this case when the GPIO buttons are on optional expansion
> board, maybe someone else (Shawn?) will help here.
>
> Best regards,
> Marek Vasut
>
You are right, it is an expansion board. But the signals do not conflict 
with any other
expansion board that I know of.


Troy
