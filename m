From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:18:07 -0800
Subject: [PATCH] arm64: dts: add baud rate to Juno stdout-path
In-Reply-To: <d0f44fbb7ffc85806ab00d7e54a64161ef79cad7.1421924801.git.robin.murphy@arm.com>
References: <d0f44fbb7ffc85806ab00d7e54a64161ef79cad7.1421924801.git.robin.murphy@arm.com>
Message-ID: <20150123221807.GK20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 11:21:32AM +0000, Robin Murphy wrote:
> Without explicit command-line parameters, the Juno UART ends up running
> at 57600 baud in the kernel, which is at odds with the 115200 baud used
> by the rest of the firmware. Since commit 7914a7c5651a5161 now lets us
> fix this by specifying default options in stdout-path, do so.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


Thanks, applied as a fix for 3.19.

-Olof
