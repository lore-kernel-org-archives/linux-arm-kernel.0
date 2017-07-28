From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 28 Jul 2017 19:39:52 +0100
Subject: [RFC PATCH 0/4] serial: uartps: Dynamic allocation
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Message-ID: <20170728193952.1f85073f@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jul 2017 11:32:23 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> Hi Alan,
> 
> this is the initial version before next step which is move
> uart_register_driver to probe function.
> I was able to get rid of static array with uart_port structures.
> It was wired with console which is also fixed.
> And the next step is the most complicated one handle .nr in uart_driver
> structure in more generic way.
> 
> Thanks,
> Michal

Sorry for the delay been on jury service

Series

Reviewed-by: Alan Cox <alan@linux.intel.com>
