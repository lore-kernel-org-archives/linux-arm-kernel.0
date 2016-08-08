From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 8 Aug 2016 18:49:37 +0200
Subject: [PATCH v6 0/8] CPUs capacity information for heterogeneous systems
In-Reply-To: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Message-ID: <20160808164937.GH6879@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:40:40PM +0100, Juri Lelli wrote:
> Patches high level description:
> 
>  o 01/08 introduces documentation for the new optional DT binding
>  o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
>    provide parsing of such information at boot time
>  o [07-08]/08 introduce sysfs attribute
> 

So generally ok with me; there does seem to be an unfortunate
duplication of code between arm and arm64 but other than that it looks
fine.
