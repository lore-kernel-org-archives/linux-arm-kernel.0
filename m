From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 11 Jan 2016 22:06:14 +1100
Subject: [PATCH v4 0/3] checkpatch: handling of memory barriers
In-Reply-To: <20160111130334-mutt-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
 <20160111130334-mutt-send-email-mst@redhat.com>
Message-ID: <CAGRGNgXnxjmvjD8_vT17ZWwK0uCsGNmXq_KdVj9KoT6NRZQvPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Mon, Jan 11, 2016 at 10:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 11, 2016 at 12:59:25PM +0200, Michael S. Tsirkin wrote:
>> As part of memory barrier cleanup, this patchset
>> extends checkpatch to make it easier to stop
>> incorrect memory barrier usage.
>>
>> This replaces the checkpatch patches in my series
>>       arch: barrier cleanup + barriers for virt
>> and will be included in the pull request including
>> the series.
>>
>> changes from v3:
>>       rename smp_barrier_stems to barrier_stems
>>       as suggested by Julian Calaby.
>
> In fact it was Joe Perches that suggested it.
> Sorry about the confusion.

I was about to point that out.

FWIW this entire series is:

Acked-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
