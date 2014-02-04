From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Feb 2014 21:07:33 +0100
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <52F10024.4030201@free-electrons.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52EA2875.5020807@free-electrons.com> <52EA2A04.2070109@gmail.com>
 <20140203231603.GA11613@1wt.eu> <52F02816.1050708@gmail.com>
 <52F10024.4030201@free-electrons.com>
Message-ID: <20140204210733.36c2eab0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 04 Feb 2014 15:58:44 +0100, Gregory CLEMENT wrote:

> > @Jason, Andrew, Gregory, Thomas:
> > Now that v3.14 is out, anything against taking this in as fixes for rc1?
> 
> I am not found of this solution I still think it should be done
> at framework level. However we still have this very annoying issue,
> and this fix is better than nothing. So I am not against taking this
> for rc1 with the hope that it will be later revert with a better
> solution.

Same opinion here. I'm fine with this solution as a temporary measure,
but it would be good to solve this problem in a nicer way. Also, making
this change doesn't impact the DT in any way, there is no problem in
having a temporary not perfect solution, and improve it later on.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
