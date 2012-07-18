From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Jul 2012 00:35:08 -0700
Subject: [RFC PATCH v2 1/2] drivers: misc: omap: add a new driver for
 ocp2scp
In-Reply-To: <201207161947.01751.arnd@arndb.de>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
 <20120716081204.GI7955@arwen.pp.htv.fi>
 <CAAe_U6JMGP3jEkkd=vqpR5KTeOnY51AOcb65zqKRRa8MtnWjzQ@mail.gmail.com>
 <201207161947.01751.arnd@arndb.de>
Message-ID: <20120718073507.GL6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120716 12:51]:
> On Monday 16 July 2012, ABRAHAM, KISHON VIJAY wrote:
> > >>
> > >> I think we should reconsider the idea of drivers/bus/ with a file per
> > >> bus in there at least for new buses, but doing a new drivers/scp/
> > >> would be ok for me if there is enough opposition against the idea
> > >> of drivers/bus aggregating different buses.
> > >
> > > I don't mind either way. The fact is that this ocp-to-scp bridge is
> > > really a TI/OMAP thing. Not sure it deserves a directory of its own.
> > 
> > Ok. Then I'll have a file in drivers/bus/ for ocp2scp driver.
> 
> Sounds good to me. I don't care if it's the only file in that directory.
> We can point the next person to a bus with a single file to that directory
> and let them add theirs.

Yes great. Sounds like that's where the omap GPMC bus driver should
end up going eventually.

Regards,

Tony
