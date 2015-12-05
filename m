From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 12:19:28 -0500
Subject: [PATCH LINUX v3 04/10] tty: xuartps: Clear interrupt status
 register in shutdown
In-Reply-To: <1448161172-19717-5-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-5-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56631CA0.5090707@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> When shutting down the UART, clear the interrupt status register.

This changelog could have expanded on the way the interrupt status
register worked so I didn't have to look this up myself.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
