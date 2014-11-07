From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 7 Nov 2014 17:19:33 +0100
Subject: [PATCH v2 06/11] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <20141107164940.663f5423@bbrezillon>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-7-git-send-email-boris.brezillon@free-electrons.com>
 <CAL_JsqJvT-gnr6AYHq42qfgS+ckZ1y6DFiPK5+-MBhHefB8_Sg@mail.gmail.com>
 <20141107164940.663f5423@bbrezillon>
Message-ID: <CAAObsKDkqksPyidfQmcHtShd3u7AFOd1RwLh3FRWPus2KjnBQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2014 16:49, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Fri, 7 Nov 2014 09:21:39 -0600
> Rob Herring <robherring2@gmail.com> wrote:
>
>> On Wed, Nov 5, 2014 at 10:01 AM, Boris Brezillon
>> <boris.brezillon@free-electrons.com> wrote:
>> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>
>> Perhaps some commit msg?
>
> Yes, I was just lazy and though this series would make another round
> anyway :-).
>
> I'll add a commit log to all my commits...
>
>>
>> While this binding seems mostly okay to me, this is the 2nd memory
>> controller binding I've looked at in the last day [1]. There are
>> probably some others already as well. This makes me think we need a
>> generic binding here. At least the node structure and how we define
>> chip selects should be common.
>
> Sure.
> Any suggestion ?

I unfortunately cannot see much benefit to a generic binding, but
maybe that's because the one in T124 is a bit special? I'm very
interested in hearing proposals though.

Thanks,

Tomeu
