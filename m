From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 17:06:27 +0000
Subject: FW: Regulator API ignored return values
In-Reply-To: <87d2uro09v.fsf@octavius.laptop.org>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB0547F@SC-VEXCH1.marvell.com>
 <87y5dsheqo.fsf@octavius.laptop.org> <87d2uro09v.fsf@octavius.laptop.org>
Message-ID: <201303221706.27733.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Chris Ball wrote:
> >
> > The reason I didn't make it a fatal error is that this is just vqmmc
> > (responsible for moving from 3.3V to 1.8V for UHS modes), not the
> > main vmmc regulator.  We can just disable those UHS modes from the
> > capabilities on the host if vqmmc is missing, or failed to enable,
> > or doesn't support those voltages, and that's what the code does now.
> 
> I've pushed this patch to mmc-next for 3.10 now, let me know if you
> disagree.

No, it's fine. Sorry for not replying earlier.

	Arnd
