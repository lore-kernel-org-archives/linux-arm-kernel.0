From: frans.klaver@xsens.com (Frans Klaver)
Date: Tue, 16 Sep 2014 16:23:11 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <20140916124200.GK28458@ci00147.xsens-tech.local>
References: <20140911151114.GD28458@ci00147.xsens-tech.local>
 <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140916090540.GJ28458@ci00147.xsens-tech.local>
 <20140916124200.GK28458@ci00147.xsens-tech.local>
Message-ID: <20140916142311.GL28458@ci00147.xsens-tech.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 02:42:00PM +0200, Frans Klaver wrote:
> On Tue, Sep 16, 2014 at 11:05:40AM +0200, Frans Klaver wrote:
> > On Mon, Sep 15, 2014 at 06:42:04PM +0200, Sebastian Andrzej Siewior wrote:
> > > If there is nothing specific to the file you do less on I have no idea
> > > what else it could if it is not the config.
> > 
> > I'll test your config and go through the differences.
> 
> So far it looks like it isn't in the config. I've tested both your and
> my config on debian wheezy on a boneblack. No lock ups.

No, skip that. It is in the config. I'll hunt it down.
