From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 23 Nov 2015 15:00:20 -0500
Subject: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter in
 start_tx
In-Reply-To: <5652BAD2.4090000@xilinx.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
 <564F4A95.3010303@hurleysoftware.com>
 <20151120165804.GV32017@xsjsorenbubuntu>
 <564F5574.4070407@hurleysoftware.com> <5652BAD2.4090000@xilinx.com>
Message-ID: <56537054.6090208@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On 11/23/2015 02:05 AM, Michal Simek wrote:
> All these tests looks very interesting. Do you have any any
> work-in-progress repo with other tests? It will be good to run all of
> them to validate our drivers.

I haven't upstreamed these yet, but I plan to do so soon, along with
tty core, pty, n_tty i/o, termios, and torture tests and some basic tools.

Regards,
Peter Hurley
