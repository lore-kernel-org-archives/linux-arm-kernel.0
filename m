From: pankaj.embedded@gmail.com (Pankaj Pandey)
Date: Mon, 28 Jun 2010 13:41:43 +0530
Subject: how to change MEM_SIZE ?
Message-ID: <AANLkTinksxNdkvSV9TtAsY79at9fDtQgIzioB48sAEig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

 How to change MEM_SIZE without hardcoding it (atleast in setup.c). How is
this handled for other archs/boards? Conditional compilation?

The MEM_SIZE can be either programmed statically or passed from redboot as
ATAGS. Initially we were keeping it as static and the MEM_SIZE default value
of 16MB was changed to 128MB. Now we are using the ATAGS passed from Redboot
to set the MEM_SIZE(256MB).


Regards,
Pankaj Pandey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100628/0183abb9/attachment.html>
