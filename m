From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 26 Jan 2012 11:12:22 +0100
Subject: i.mx serial driver expanion (DTR/DSR, DCD, rs485)
In-Reply-To: <20120125223042.GE5446@pengutronix.de>
References: <3F263ABB4EDE344D974E1983B568077399FDA016@EX-DAG01.eckelmann.group>
 <20120125223042.GE5446@pengutronix.de>
Message-ID: <20120126101222.GA2611@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 11:30:42PM +0100, Sascha Hauer wrote:
> On Mon, Jan 23, 2012 at 10:14:33AM +0000, Mehnert, Torsten wrote:
> > Hi Sascha,
> > 
> > we are currently developing at the imx serial driver. We are planing to
> > implement two new functions and want to share them with others.
> > 
> > Now the question: Which of our code could be interesting for mainline?
> > 
> > 1.) Set and readout DSR/DTR in DTE style, handle DCD
> > 
> > 2.) handle direction handling in RS485 Master mode (like the amtel does,
> > Using TIOCSRS485 and TIOCGRS485).
> 
> Both seem interesting. Feel free to post it to the relevant lists. Even
> if the the patches do not make it to mainline it's still good for other
> people when they can find it in the archives.

Don't forget to include linux-serial at vger.kernel.org, too.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120126/f75c5cd9/attachment-0001.sig>
