From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 11 Sep 2014 11:27:32 +0200
Subject: [PATCH v5 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <540708DC.9060901@linux.vnet.ibm.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
 <54020F00.2030807@linux.vnet.ibm.com>
 <CAKfTPtBq89SX=7=bXu2za7oXi1Lid_5ara-WputrtE8kCqcZcw@mail.gmail.com>
 <5406DB43.1030506@linux.vnet.ibm.com>
 <CAKfTPtCXBYSbXVgdeyMtvuK8aZaRBzhs9S3=+V2jvXnoCJFqBQ@mail.gmail.com>
 <540708DC.9060901@linux.vnet.ibm.com>
Message-ID: <20140911092732.GS3190@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 05:56:04PM +0530, Preeti U Murthy wrote:
> On 09/03/2014 05:14 PM, Vincent Guittot wrote:
> > On 3 September 2014 11:11, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> >> On 09/01/2014 02:15 PM, Vincent Guittot wrote:
> >>> On 30 August 2014 19:50, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> >>>> Hi Vincent,
> >>>>> index 18db43e..60ae1ce 100644

Guys, really, trim excess crap. This email had over 150 lines of garbage
and 5 pointless quote levels or so before there was anything useful.
