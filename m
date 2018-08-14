From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 14 Aug 2018 10:52:16 -0600
Subject: Warning when using eMMC and partprobe: generic_make_request:
 Trying to write to read-only block-device
In-Reply-To: <CA+55aFzisr_YkMJggnG0O4ALzjwKsPeio71PJY8Jur4afnOVOg@mail.gmail.com>
References: <7f57199f45df7212fdbba0bd1e78142a@agner.ch>
 <CAOi1vP9Y5Nrr7kVo5GAKnS4casbXPa+LSgY=si=mAW6OHs7-BA@mail.gmail.com>
 <CA+55aFwyCmYfUrGt61d-6B=1XiTLoudNO=_bQ9-g_rDg8Ao_VA@mail.gmail.com>
 <22fff85b-63e5-3cfe-0e72-255044e53bab@kernel.dk>
 <e5589461-6331-7c4c-4171-7d7e304410e0@kernel.dk>
 <CA+55aFzisr_YkMJggnG0O4ALzjwKsPeio71PJY8Jur4afnOVOg@mail.gmail.com>
Message-ID: <629769cc-d50e-f7f1-7327-23c751f95be2@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/14/18 10:51 AM, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 9:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>>
>>> We probably just want to special case a flush for this check. In other
>>> situations, like resource allocation and issue, we'd want to consider
>>> it a write.
>>
>> Ala:
> 
> Ack, looks sane to me.

I'll add it to a followup pull this window, mark it stable since it's
hitting 4.18.

-- 
Jens Axboe
