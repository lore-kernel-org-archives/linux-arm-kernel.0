From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 16 Jan 2015 13:34:26 +0100
Subject: [PATCH 1/2] clk: pxa: add pxa3xx clock driver
In-Reply-To: <87ppar4onn.fsf@free.fr> (Robert Jarzmik's message of "Tue, 06
 Jan 2015 21:53:00 +0100")
References: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
 <87ppar4onn.fsf@free.fr>
Message-ID: <874mrqykdp.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Hi Daniel,
>
> I'd need a test to see if the pxa3xx clocks are actually working.
> I prepared a tree in here :
>   git fetch https://github.com/rjarzmik/linux work/clocks-pxa
>
> Could you make a run, and if it works for you, send me a copy of
> /sys/kernel/debug/clk/clk_summary please ?
>
> I'm really curious if suspend/resume is working, as I "forgot" to include the
> CKENA/CKENB save/restore code.

Hi Marek, Ezequiel and Daniel,

Would any one of you give a try to this tree (3.18-rc1 based) ? I'd like to have
some testing before breaking all the pxa3xx platforms.

Cheers.

-- 
Robert
