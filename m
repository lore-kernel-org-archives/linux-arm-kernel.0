From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 29 Nov 2010 08:52:35 +0100
Subject: [PATCH 28/51] ARM: mx25: dynamically allocate mxc-ehci devices
In-Reply-To: <54321.212.121.242.58.1291016083.squirrel@mail.fqingenieria.es>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<4CEFCC9A.2020500@fqingenieria.es>
	<20101126194831.GA25293@pengutronix.de>
	<54321.212.121.242.58.1291016083.squirrel@mail.fqingenieria.es>
Message-ID: <20101129075235.GA20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jaume,

On Mon, Nov 29, 2010 at 08:34:43AM +0100, jaume at fqingenieria.es wrote:
> >> On 17/11/2010 22:29, Uwe Kleine-K?nig wrote:
> >>> According to the reference manual of the i.MX25 the host controller
> >>> uses an
> >>> offset of 0x200 not 0x400 as was specified in the resources for
> >>> mxc_usbh2.
> >>>
> >>> Needs-Testing: yes
> > Actually I wanted that tag to make me stop sending this patch out.
> > Well, not too bad IMHO.
> 
> Did you mean a way of testing/marking the patches? Please clarify.
I intended to test this change before sending it out.  That's why I
wrote "Needs-Testing: yes" into the commit log.  I somehow thought I'd
see that before sending the patch out.  The upside of my failure here is
that we now know the definitive offset and hopefully in the next
revision of the documentation the value is fixes.  So the world became a
bit better :-)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
