From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Jun 2013 15:01:39 -0700
Subject: [PATCH 1/3] pinctrl: pinctrl-single: enhance to configure
 multiple pins of different modules
In-Reply-To: <1369145282-14419-3-git-send-email-prakash.pm@ti.com>
References: <1369145282-14419-1-git-send-email-prakash.pm@ti.com>
 <1369145282-14419-3-git-send-email-prakash.pm@ti.com>
Message-ID: <20130605220138.GE3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Manjunathappa, Prakash <prakash.pm@ti.com> [130521 07:13]:
> Add support to configure multiple pins in each register, existing
> implementation added by [1] does not support full fledge multiple pin
> configuration in single register, reports a pin clash when different
> modules configure different bits of same register. The issue reported
> and discussed here
> http://www.spinics.net/lists/arm-kernel/msg235213.html
> 
> With pinctrl-single,bits-per-mux property specified, use function-mask
> property to find out number pins to configure. Allocate and register
> pin control functions based sub mask.

Thanks for fixing this! Looks good to me, and things keep
working for me just fine with these applied:

Acked-by: Tony Lindgren <tony@atomide.com>
