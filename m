From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Fri, 11 Oct 2013 13:59:00 +0200
Subject: [PATCH] serial: prepare for 9bit data
In-Reply-To: <20130926224755.GA15399@kroah.com>
References: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
 <20130926224755.GA15399@kroah.com>
Message-ID: <5257E804.6020800@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Dne 27.9.2013 00:47, Greg KH napsal(a):
> On Mon, Sep 23, 2013 at 02:07:32PM +0200, Jiri Prchal wrote:
>> This patch adds 9bit data possibility for serial_core. Please confirm that I did it right way at right place. I'll make atmel_serial driver for 9bit data later.
>
> Please wrap your lines properly.
>
> I'd rather wait to add this type of patch _after_ you have tested it and
> verified that your driver works, and take that patch at the same time.
>
> Otherwise, this is just added cruft that no one is using, and I'd have
> to remove it :)
No one is using it because it is NOT implemented.
Try to search internet for "9bit serial" to see how many people like to use it.
But I probably not bother to do it and I'll try some tricks with parity.
As many others.

Best regard
Jiri
