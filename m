From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 4 Mar 2018 19:15:15 +0100 (CET)
Subject: [PATCH 1/2] mmc: bcm2835: reset host on timeout
In-Reply-To: <20180304173653.78adac53@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
 <166274019.307112.1520085525833@email.1und1.de>
 <20180304173653.78adac53@naga.suse.cz>
Message-ID: <1331293394.179376.1520187315077@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

> Michal Such?nek <msuchanek@suse.de> hat am 4. M?rz 2018 um 17:36 geschrieben:
> 
> 
> On Sat, 3 Mar 2018 14:58:45 +0100 (CET)
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > In a github issue, i've read that badblocks could reproduce the issue
> > more likely.
> 
> How many iterations of badblocks? It doe snot reproduce the issue for
> me.

i asked for the parameters here:

https://github.com/raspberrypi/linux/issues/2392

Stefan

> 
> Thanks
> 
> Michal
