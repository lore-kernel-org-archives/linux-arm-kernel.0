From: alan@linux.intel.com (Alan Cox)
Date: Thu, 23 Aug 2012 11:53:00 +0100
Subject: [PATCHv4 3/9] serial: vt8500: Add devicetree support for
 vt8500-serial
In-Reply-To: <1345707346-9035-4-git-send-email-linux@prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <1345707346-9035-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <20120823115300.5fdb5cd1@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Aug 2012 19:35:39 +1200
Tony Prisk <linux@prisktech.co.nz> wrote:

> Increase vt8500_max_ports to 6 as the WM8505 as 6 available uarts.
> Use devicetree port id as primary addressing for ports but allow
> auto-allocation if id not specified.

Acked-by: Alan Cox <alan@linux.intel.com>

for the serial bits
