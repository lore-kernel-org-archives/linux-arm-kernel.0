From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Mar 2017 13:35:17 -0700
Subject: [PATCH] netfilter: nfnetlink_cthelper: Fix memory leak
In-Reply-To: <CAKdAkRSyMyGDFP_VotukxZWpfTr1GUfKpD_+1mP=djz1sG+WRw@mail.gmail.com>
References: <1490079425-6172-1-git-send-email-jeffy.chen@rock-chips.com>
 <CAKdAkRSyMyGDFP_VotukxZWpfTr1GUfKpD_+1mP=djz1sG+WRw@mail.gmail.com>
Message-ID: <CAD=FV=X1_d_iT_a_f6Q0iWkO-g7DejTqaMJo8qGc-na-FZOMPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 21, 2017 at 1:14 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Mar 20, 2017 at 11:57 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> We have memory leaks of nf_conntrack_helper & expect_policy.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>
> This looks reasonable to me:
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> But you need to send it to correct lists, and linux-arm-kernel is not it:
>
> ./scripts/get_maintainer.pl -f net/netfilter/nfnetlink_cthelper.c
> Pablo Neira Ayuso <pablo@netfilter.org> (supporter:NETFILTER)
> Jozsef Kadlecsik <kadlec@blackhole.kfki.hu> (supporter:NETFILTER)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
> netfilter-devel at vger.kernel.org (open list:NETFILTER)
> coreteam at netfilter.org (open list:NETFILTER)
> netdev at vger.kernel.org (open list:NETWORKING [GENERAL])
> linux-kernel at vger.kernel.org (open list)

This was picked up and re-posted (with changes) at:

http://marc.info/?l=netfilter-devel&m=149010052628333&w=2
