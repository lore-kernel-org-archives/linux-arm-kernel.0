From: kosaki.motohiro@jp.fujitsu.com (KOSAKI Motohiro)
Date: Tue, 26 May 2015 23:49:03 -0400
Subject: [RFC PATCH 1/2] kernel/fork.c: add a function to calculate page
 address from thread_info
In-Reply-To: <1432483292-23109-1-git-send-email-jungseoklee85@gmail.com>
References: <1432483292-23109-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <CAHGf_=oMDPscgJ0bdr+QrV24n3KL3BC5qe8KGa=dePxg4tc4Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 24, 2015 at 12:01 PM, Jungseok Lee <jungseoklee85@gmail.com> wrote:
> A current implementation assumes thread_info address is always correctly
> calculated via virt_to_page. It restricts a different approach, such as
> thread_info allocation from vmalloc space.
>
> This patch, thus, introduces an independent function to calculate page
> address from thread_info one.
>
> Suggested-by: Sungjinn Chung <barami97@gmail.com>
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  kernel/fork.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I haven't receive a path [2/2] and haven't review whole patches. But
this patch itself is OK to me.
Acked-by: KOSAKI Motohiro <kosaki.motohiro@fujitsu.com>
