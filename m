From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Sat, 5 Dec 2015 09:25:53 -0800
Subject: [PATCH LINUX v3 04/10] tty: xuartps: Clear interrupt status
 register in shutdown
In-Reply-To: <56631CA0.5090707@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-5-git-send-email-soren.brinkmann@xilinx.com>
 <56631CA0.5090707@hurleysoftware.com>
Message-ID: <CAAtXAHdc5M=NVY-NMX1yWbObd3_fOjX8=TMdHs-hvjxBEzu3zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 5, 2015 at 9:19 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
>> When shutting down the UART, clear the interrupt status register.
>
> This changelog could have expanded on the way the interrupt status
> register worked so I didn't have to look this up myself.
>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
