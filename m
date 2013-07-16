From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 16 Jul 2013 09:17:44 -0300
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <13fe673f255.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch> <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
 <13fe673f255.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
Message-ID: <20130716121743.GB2317@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Tue, Jul 16, 2013 at 09:48:56AM +0200, Sebastian Hesselbarth wrote:
> 
> In the discussion about orion clocksource Russell was proposing a generic 
> thread-safe write. That puts a single lock around all those writes. Of 
> course, it will also blocked by totally unrelated thread-safe register 
> accesses but should prevent us from having dozens of locks and solves the 
> symbol issue.
> 

Thanks for the insight! I'll try to dig this suggestion in the clocksource
discussion. Do you have any plans for posting the clocksource soon?
This way I can base this series on something that's in Jason's trees...

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
