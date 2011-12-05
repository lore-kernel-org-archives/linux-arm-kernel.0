From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 5 Dec 2011 10:16:32 +0800
Subject: [RFC PATCH v1 4/7] media: videobuf2: introduce VIDEOBUF2_PAGE
 memops
In-Reply-To: <CAKnK67SDyFCbLjpwzY9JQiBHJTgpF9uXOq+GUBW7oWv_5gZzbA@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
 <1322817178-8931-5-git-send-email-ming.lei@canonical.com>
 <CAKnK67SDyFCbLjpwzY9JQiBHJTgpF9uXOq+GUBW7oWv_5gZzbA@mail.gmail.com>
Message-ID: <CACVXFVMW0FaAMYJ3rdqtwsK9HGBwcd5gW0TTG_ix=+7TH1yfsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 3, 2011 at 12:35 AM, Aguirre, Sergio <saaguirre@ti.com> wrote:
> Hi Ming,
>> diff --git a/include/media/videobuf2-page.h b/include/media/videobuf2-page.h
>> new file mode 100644
>> index 0000000..29b3e20
>> --- /dev/null
>> +++ b/include/media/videobuf2-page.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * videobuf2-vmalloc.h - vmalloc memory allocator for videobuf2
>> + *
>> + * Copyright (C) 2010 Samsung Electronics
>> + *
>> + * Author: Pawel Osciak <pawel@osciak.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#ifndef _MEDIA_VIDEOBUF2_VMALLOC_H
>> +#define _MEDIA_VIDEOBUF2_VMALLOC_H
>
> Copy-paste much? :)

Yes, will fix it in next version, :-)

thanks,
--
Ming Lei
