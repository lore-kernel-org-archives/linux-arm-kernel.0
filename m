From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 4 Apr 2016 14:08:46 -0700
Subject: [PATCH v7 5/5] serial: pl011: add console matching function
In-Reply-To: <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-6-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <5702D7DE.50406@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 06:40 AM, Aleksey Makarov wrote:
> This patch adds function pl011_console_match() that implements
> method match of struct console.  It allows to match consoles against
> data specified in a string, for example taken from command line or
> compiled by ACPI SPCR table handler.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
