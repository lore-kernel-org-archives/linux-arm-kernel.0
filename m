From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2011 16:43:35 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <2AF43CEDFDB649AE946E8F9F98A5AE48@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105301604.38026.arnd@arndb.de>
	<2AF43CEDFDB649AE946E8F9F98A5AE48@subhasishg>
Message-ID: <201105301643.35997.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 May 2011, Subhasish Ghosh wrote:
> >
> > During the time when the drivers are in staging, all files need to
> > be in the same directory, including the header and the drivers using it.
> > They can get moved at the time when the driver gets turned into
> > a regular non-staging driver.
> 
> OK, so the UART implementation needs to be moved into staging as well ?
> 
> And what about the boardfile changes, array of mfd_cells implementation etc. 

All of that, too.

Note that you are citing exactly the points that are the reason for the
discussion we are having. The mfd_cells are the main concern for the cases
where the information is not static.

	Arnd
