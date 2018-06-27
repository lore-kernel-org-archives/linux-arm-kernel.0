From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 Jun 2018 10:50:23 +0200
Subject: [PATCH v2 1/2] clk: pxa: export 32kHz PLL
In-Reply-To: <201806270855.xvEN3vnK%fengguang.wu@intel.com> (kbuild test
 robot's message of "Wed, 27 Jun 2018 08:16:16 +0800")
References: <20180626200308.16192-1-robert.jarzmik@free.fr>
 <201806270855.xvEN3vnK%fengguang.wu@intel.com>
Message-ID: <87vaa4lik0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kbuild test robot <lkp@intel.com> writes:

> All errors (new ones prefixed by >>):
>
>    drivers/clk/pxa/clk-pxa25x.c: In function 'pxa25x_register_plls':
>>> drivers/clk/pxa/clk-pxa25x.c:298:17: error: expected ')' before ';' token
>               32768);
>                     ^
>>> drivers/clk/pxa/clk-pxa25x.c:304:1: error: expected ';' before '}' token
>     }
Meh a missing closing parenthesis ... I'll send a v3.

Cheers.

--
Robert
