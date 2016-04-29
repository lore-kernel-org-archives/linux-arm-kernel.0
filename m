From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 28 Apr 2016 17:43:02 -0700
Subject: [PATCH v7 5/5] serial: pl011: add console matching function
In-Reply-To: <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <20160429004302.GB31752@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 04:40:27PM +0300, Aleksey Makarov wrote:
> This patch adds function pl011_console_match() that implements
> method match of struct console.  It allows to match consoles against
> data specified in a string, for example taken from command line or
> compiled by ACPI SPCR table handler.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
