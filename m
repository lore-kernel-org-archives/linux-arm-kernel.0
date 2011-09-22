From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 22 Sep 2011 14:31:30 +0800
Subject: [PATCH] dmaengine: delete redundant chan_id and chancnt
	initialization in dma drivers
In-Reply-To: <CABb+yY3mCHwWx-8gQG75107eWQBT1kPDu59vi9vHU+OQFXq_kg@mail.gmail.com>
References: <1316166200-20595-1-git-send-email-Baohua.Song@csr.com>
	<CABb+yY2L=wfRoascoriAcnNMKkV7LbQEHCpp78+rCY=aM46x7A@mail.gmail.com>
	<CAGsJ_4zURv1_zJ0rwZawa8VSOw0kT9U4-cCCj2Q4-BhV1pdTHA@mail.gmail.com>
	<CABb+yY3T7JmcLXY-6GYHqF+3SiVK5N0xGzqsE8pv8A+S10hWQw@mail.gmail.com>
	<CABb+yY3mCHwWx-8gQG75107eWQBT1kPDu59vi9vHU+OQFXq_kg@mail.gmail.com>
Message-ID: <CAGsJ_4x-SxYLyuyR9nQ530DhmfYN-Bqc2DOSyAVhM=h3zxCvMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/22 Jassi Brar <jassisinghbrar@gmail.com>:
> On Thu, Sep 22, 2011 at 11:11 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>
>>> client drivers can request a specific chan_id just like it can request a gpio.
>> No dear. That's not gonna fly if we are to have common client drivers
>> across SoCs.
>>
> Btw, I meant you can't simply have clients specify a channel number and
> get the channel in a portable manner. Clients need to specify the capabilities
> they need of the channel.

if the dmac is flexible in design, what you said is right. but the
problem is that there are some chips which actually fix one channel to
one peripheral.

-barry
