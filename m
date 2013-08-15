From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 15 Aug 2013 17:05:20 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815042812.GA8968@kroah.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
Message-ID: <CAGsJ_4xVJ20+TgSvFx+QBi6rMTTD1uRbe=RA1D4md5yGdhaXtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/15 Greg KH <greg@kroah.com>:
[snip]
>
>> 2. IPC support for communication between RTOS in security mode and
>> Linux in non-security mode, as we need to communicate rich commands
>> and buffers
>
> What about using the virtual protocols we already have today for the
> existing hypervisors?  Don't reinvent something new if you don't have
> to.

yes. i agree. that is why i am saying virtio and RPMsg.

-barry
