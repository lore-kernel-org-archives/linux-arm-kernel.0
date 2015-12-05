From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 12:23:46 -0500
Subject: [PATCH LINUX v3 07/10] tty: xuartps: Acquire port lock for
 shutdown
In-Reply-To: <1448161172-19717-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-8-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56631DA2.5050402@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Shutting down the UART port can happen while console operations are in
> progress. Holding the port lock serializes these operations and avoids
> the UART HW to be disabled in the middle of console prints.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
