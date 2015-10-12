From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Oct 2015 09:50:01 +0200
Subject: [PATCH 6/6] watchdog: sama5d4: try to set timeout from device
 tree first
In-Reply-To: <1444340074-15437-7-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
 <1444340074-15437-7-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20151012075001.GB3558@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

The rest of the series looks good to me, one comment below:

On 08/10/2015 at 23:34:34 +0200, Sylvain Rochet wrote :
> watchdog_init_timeout function doesn't try to get the "timeout-sec" DT
> property if timeout_parm is not zero. This change makes this DT property
> working for the sama5d4 watchdog driver.
> 

While I'm not sure of the feasibility, I think that the module parameter
should override the DT property.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
