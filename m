From: jcm@jonmasters.org (Jon Masters)
Date: Sun, 10 Dec 2017 15:40:08 -0500
Subject: [PATCH 0/2] acpi, x86: Add SPCR table support
In-Reply-To: <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171208062925.64ov23u7oxmdfzyk@gmail.com>
 <f078ada7-1e30-41cc-28dc-077ed2a5986d@redhat.com>
Message-ID: <d3c46a6f-745c-7643-c55f-781a6ffea8f4@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2017 09:29 AM, Prarit Bhargava wrote:

> If I disable "Serial Port Console Debug" in my BIOS I still see the SPCR configured:
> 
> [root at prarit-lab ~]# dmesg | grep SPCR
> [    0.000000] ACPI: SPCR 0x0000000069031000 000050 (v01
> 00000000      00000000)
> 
> AFAICT the SPCR is always enabled on some systems.

It's part of some of the Windows design flows that it gets incorporated,
and it should always be present.

Jon (not talking about AArch64/ARM/arm/ARMv8-A/64-bit ARM/Go ARM Go).
