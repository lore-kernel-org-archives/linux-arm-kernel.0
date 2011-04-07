From: Victor.Boivie@sonyericsson.com (Boivie, Victor)
Date: Thu, 7 Apr 2011 15:22:57 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <20110407131810.GA6450@elliptictech.com>
References: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
	<20110407131810.GA6450@elliptictech.com>
Message-ID: <56A05FDF86209947BB88FDF67E6D4A1073F0B973E2@SELDMBX04.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +config CMDLINE_EXTEND
> > +	bool "Extend bootloader kernel arguments"
> > +	depends on CMDLINE != ""
> > +	help
> > +	  The default kernel command string will be concatenated with the
> > +	  arguments provided by the boot loader.
> 
> Since concatenation is not commutative, this help text should describe
> exactly the order in which the arguments are concatenated.  How about
> this instead:
> 
>   The command-line arguments provided by the boot loader will be
>   appended to the default kernel command string.

I completely agree. New patch upcoming. Thanks.

Best regards,
Victor Boivie,
Sony Ericsson Mobile Communications AB
