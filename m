From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 19:47:01 +0000
Subject: [RFC PATCH v2 1/2] drivers: misc: omap: add a new driver for
 ocp2scp
In-Reply-To: <CAAe_U6JMGP3jEkkd=vqpR5KTeOnY51AOcb65zqKRRa8MtnWjzQ@mail.gmail.com>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
 <20120716081204.GI7955@arwen.pp.htv.fi>
 <CAAe_U6JMGP3jEkkd=vqpR5KTeOnY51AOcb65zqKRRa8MtnWjzQ@mail.gmail.com>
Message-ID: <201207161947.01751.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, ABRAHAM, KISHON VIJAY wrote:
> >>
> >> I think we should reconsider the idea of drivers/bus/ with a file per
> >> bus in there at least for new buses, but doing a new drivers/scp/
> >> would be ok for me if there is enough opposition against the idea
> >> of drivers/bus aggregating different buses.
> >
> > I don't mind either way. The fact is that this ocp-to-scp bridge is
> > really a TI/OMAP thing. Not sure it deserves a directory of its own.
> 
> Ok. Then I'll have a file in drivers/bus/ for ocp2scp driver.

Sounds good to me. I don't care if it's the only file in that directory.
We can point the next person to a bus with a single file to that directory
and let them add theirs.

	Arnd
