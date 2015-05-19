From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 May 2015 12:11:51 +0100
Subject: [PATCH v2 0/5]  arm64: Juno DT updates and new DT for Juno R1
In-Reply-To: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
References: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <555B1A77.9070403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/15 18:28, Liviu Dudau wrote:
> This series restructures the Juno DT files and introduces the DT
> for the new Juno R1. The board is an update of the Juno R0 with
> support for PCIe, but the current series only brings the board to
> parity with Juno R0. The series that enable the PCIe Generic Host
> Bridge to be used on Juno R1 will be posted separately.
>
> Changes from v1:
>   - Moved memory node inside juno-base.dtsi as this is common between
>     boards and unlikely to change soon.
>   - Added "arm,juno-r1" as compatible string in juno-r1.dts at Jon Medhurst's
>     suggestion.

It would be good to add these juno* compatible somewhere in the binding
document. In past I have seen checkpatch complaining about missing
compatibles on vexpress(which is annoying if you are not adding it
but fixing a bug around existing node).

Otherwise the whole series looks good to me. So feel free to add

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
