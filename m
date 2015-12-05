From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 12:17:59 -0500
Subject: [PATCH LINUX v3 03/10] tty: xuartps: Don't consider circular
 buffer when enabling transmitter
In-Reply-To: <1448161172-19717-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56631C47.6010905@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Restarting the transmitter even if the circ buffer is empty may be
> necessary to push out remaining data when the port is restarted after
> being stopped.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
