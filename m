From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 01 Feb 2010 09:08:16 +1300
Subject: [patch v2 1/2] at91_udc.c read_fifo timing issue
In-Reply-To: <3efb10971001290904p74b1919aif8ff013f050123a9@mail.gmail.com>
References: <20100129162029.998540038@gmail.com>	
	<20100129162155.709756286@gmail.com>
	<3efb10971001290904p74b1919aif8ff013f050123a9@mail.gmail.com>
Message-ID: <4B65E330.3040000@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remy Bohmer wrote:
> Hi Harro,
> 
> 2010/1/29 Harro Haan <hrhaan@gmail.com>:
>> This solves the read_fifo timing issue for example seen with CDC Ethernet.
>> See the comments below for more info.
>>
>> Signed-off-by: Harro Haan <hrhaan@gmail.com>
>> ---
>>  drivers/usb/gadget/at91_udc.c |   46 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 42 insertions(+), 4 deletions(-)
>>
> Acked-by: Remy Bohmer <linux@bohmer.net>

Can I get your Acked-by for my patch also Remy?

Harro, I can either submit my patch to the patch system separately, or
you can put it through with your series with my From/Signed-off-by tag
on it.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
