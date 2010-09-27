From: gregkh@suse.de (Greg KH)
Date: Mon, 27 Sep 2010 14:24:58 -0700
Subject: [PATCH 11/13 v3] serial: Add OMAP high-speed UART driver
In-Reply-To: <878w2moqi5.fsf@deeprootsystems.com>
References: <43868.10.24.255.17.1285599049.squirrel@dbdmail.itg.ti.com>
	<878w2moqi5.fsf@deeprootsystems.com>
Message-ID: <20100927212458.GA28283@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 27, 2010 at 01:55:46PM -0700, Kevin Hilman wrote:
> [resent with correct address for Greg, sorry for duplicates.]
> 
> Greg,
> 
> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > This patch adds driver support for OMAP2/3/4 high speed UART.
> 
> According to MAINTAINERS, you seem to be the one looking after the
> serial core.  Are you the one to ack/merge new drivers?

Yup, but Alan Cox is also a good person to get review from as well.

> With your ack, we can merge this through the OMAP tree along with the
> rest of the series that has OMAP-specific platform reorg and updates.
> 
> If you're not the right person, please let us know who would be the
> right person to ack/sign-off on this.

Cc both of us so we can review it please.

thanks,

greg k-h
