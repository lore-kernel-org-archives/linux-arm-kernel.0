From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 04 Mar 2015 21:07:21 +0100
Subject: [RFC PATCH 01/18] serial: remove obsolete msm_serial_hs driver
In-Reply-To: <1425499409.2090.7.camel@tiscali.nl>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <1425497592-1831064-2-git-send-email-arnd@arndb.de>
 <1425499409.2090.7.camel@tiscali.nl>
Message-ID: <1425499641.2090.10.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle schreef op wo 04-03-2015 om 21:03 [+0100]:
> Arnd Bergmann schreef op wo 04-03-2015 om 20:32 [+0100]:
> > Linux currently has two drivers for the same hardware: msm_serial
> > and msm_serial_hs. Only the former is being actively maintained,
> > and the latter is not used by any in-tree board files, so we
> > can safely remove it.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arnd.de>
> > ---
> >  drivers/tty/serial/Kconfig                  |   12 -
> >  drivers/tty/serial/msm_serial_hs.c          | 1874 ---------------------------
> 
> I haven't even bothered to check, but in a diff stat like this one
> expects a line like
>     drivers/tty/serial/Makefile               |     1 -
> 
> here. Is that expectation correct?
> 
> >  include/linux/platform_data/msm_serial_hs.h |   49 -
> >  3 files changed, 1935 deletions(-)
> >  delete mode 100644 drivers/tty/serial/msm_serial_hs.c
> >  delete mode 100644 include/linux/platform_data/msm_serial_hs.h

Please note that your own email address is
    arnd at arndb.de

(I fixed up the Cc list for this message. And I don't do smilies.)


Paul Bolle
