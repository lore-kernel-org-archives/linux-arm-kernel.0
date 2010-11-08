From: alan@linux.intel.com (Alan Cox)
Date: Mon, 8 Nov 2010 10:46:41 +0000
Subject: [PATCH 2/6 v3] serial: Add support for UART on VIA VT8500 and
	compatibles
In-Reply-To: <20101108005853.GA21872@alchark-u3s.lan>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-2-git-send-email-alchark@gmail.com>
	<20101107230801.5214f353@linux.intel.com>
	<20101108005853.GA21872@alchark-u3s.lan>
Message-ID: <20101108104641.07587f50@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static struct console vt8500_console = {
> +	.name = "ttyS",

You missed a ttyS

Otherwise looks great.

Alan
