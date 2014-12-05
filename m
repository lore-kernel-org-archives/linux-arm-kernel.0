From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Fri, 5 Dec 2014 09:50:04 +0530
Subject: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
In-Reply-To: <20141204183242.GJ7944@katana>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-2-git-send-email-harinik@xilinx.com>
 <20141204183242.GJ7944@katana>
Message-ID: <CAFcVEC+mpfjYB2K5eci-BFfjyKXvbxOOBVX_CH=ck1xJ+V9goQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 5, 2014 at 12:02 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> +             /*
>> +              * If the device is sending data If there is further
>> +              * data to be sent. Calculate the available space
>> +              * in FIFO and fill the FIFO with that many bytes.
>> +              */
>
> This comment looks broken. In general, I think there should be more
> comments explaining why things have to be done this way.
>

There's some grammatical errors here. Let me correct it and add more
comments.

Regards,
Harini
