From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 17 Jan 2016 15:05:11 -0800
Subject: mvsdio not working on OpenRD
In-Reply-To: <20160115220039.GD18908@darkstar.musicnaut.iki.fi>
References: <20160110042619.GA22738@jirafa.cyrius.com>
 <20160110153843.GA22229@lunn.ch>
 <20160115180339.GC18908@darkstar.musicnaut.iki.fi>
 <20160115192217.GA12145@jirafa.cyrius.com>
 <20160115220039.GD18908@darkstar.musicnaut.iki.fi>
Message-ID: <20160117230511.GE24567@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [2016-01-16 00:00]:
> BTW, the GPIO hogging binding used in the patch might not be
> supported by the old Debian 3.16 kernel. :-(

We don't actually care about 3.16.  Debian's 3.16 uses the board file
anyway, so none of these bugs show up.  (However, 3.16 is often a good
way to test since it has support both for board file and DTB.)

-- 
Martin Michlmayr
http://www.cyrius.com/
