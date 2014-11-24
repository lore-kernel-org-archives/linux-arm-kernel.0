From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Mon, 24 Nov 2014 15:39:11 +0000
Subject: [PATCH v9 02/10] sched: Track group sched_entity usage
 contributions
In-Reply-To: <CAKfTPtBZWDSWVYQ9VE8=rsnsb2kLyUAsc5d_bvcypXE2JgarYQ@mail.gmail.com>
References: <1415033687-23294-1-git-send-email-vincent.guittot@linaro.org>
 <1415033687-23294-3-git-send-email-vincent.guittot@linaro.org>
 <20141121123509.GC23177@e105550-lin.cambridge.arm.com>
 <CAKfTPtBZWDSWVYQ9VE8=rsnsb2kLyUAsc5d_bvcypXE2JgarYQ@mail.gmail.com>
Message-ID: <20141124153911.GJ23177@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 02:04:21PM +0000, Vincent Guittot wrote:
> On 21 November 2014 at 13:35, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > What happened to the update of se->avg.utilization_avg_contrib in
> > __synchronize_entity_decay()? It seems to have disapperead after v7.
> 
> It was moved in patch 1 where it is is right place

Ahh... I missed that :)
