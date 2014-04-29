From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 29 Apr 2014 15:43:53 +0100
Subject: [PATCH v4] drivercore: deferral race condition fix
In-Reply-To: <20140429131332.GA7049@kroah.com>
References: <1398774909-13649-1-git-send-email-grant.likely@linaro.org>
 <20140429131332.GA7049@kroah.com>
Message-ID: <CACxGe6ttEonR5iESqbYeBgVx_kU48tTD3t_QYD1-8Gf2gi3yew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 2:13 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 29, 2014 at 01:35:09PM +0100, Grant Likely wrote:
>> When the kernel is built with CONFIG_PREEMPT it is possible to reach a state
>> when all modules loaded but some driver still stuck in the deferred list
>> and there is a need for external event to kick the deferred queue to probe
>> these drivers.
[...]
>> Hi Greg,
>>
>> This change needs to go into 3.15. I've got this patch in the
>> devicetree/merge branch of my tree and can ask Linus to pull it directly
>> if you would like.
>
> Sure, that would be fine:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks Greg

I'll give it a few days in linux-next and then ask Linus to pull.

g.
