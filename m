From: dirk.behme@gmail.com (Dirk Behme)
Date: Sun, 17 Feb 2013 07:31:03 +0100
Subject: [PATCH v2] ARM:kernel: a bug for perf by a redundancy character
 ';'
In-Reply-To: <51205C41.80609@asianux.com>
References: <51205C41.80609@asianux.com>
Message-ID: <51207927.3050400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.02.2013 05:27, schrieb Chen Gang:
> 
>    delete the redundancy character ';', which will cause issue.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Acked-by: Dirk Behme <dirk.behme@gmail.com>

I would prefer Will's version of the subject and commit message

http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commitdiff;h=21fa771c94c4359807bb92dc8532b25c323ac543

And, btw, the Ack was for Will's version ;)

Dirk

> ---
>   arch/arm/kernel/perf_event.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 31e0eb3..a892067 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
>   	}
>   
>   	if (event->group_leader != event) {
> -		if (validate_group(event) != 0);
> +		if (validate_group(event) != 0)
>   			return -EINVAL;
>   	}
>   
> 
