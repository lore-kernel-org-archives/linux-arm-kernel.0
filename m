From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Dec 2014 13:08:05 +0100
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
Message-ID: <1918116.UxUgDPTmcq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 December 2014 16:05:04 Ray Jui wrote:
> +
> +- linux,gpio-base:
> +    Base GPIO number of this controller
> +
> 

We've NAK'ed properties like this multiple times before, and it
doesn't get any better this time. What are you trying to achieve
here?

	Arnd
