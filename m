From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 May 2015 22:14:23 +0200
Subject: [PATCH v2 0/5]  arm64: Juno DT updates and new DT for Juno R1
In-Reply-To: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
References: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <4136868.8yCICAPH00@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 18:28:24 Liviu Dudau wrote:
> This series restructures the Juno DT files and introduces the DT
> for the new Juno R1. The board is an update of the Juno R0 with
> support for PCIe, but the current series only brings the board to
> parity with Juno R0. The series that enable the PCIe Generic Host
> Bridge to be used on Juno R1 will be posted separately.
> 
> Changes from v1:
>  - Moved memory node inside juno-base.dtsi as this is common between
>    boards and unlikely to change soon.
>  - Added "arm,juno-r1" as compatible string in juno-r1.dts at Jon Medhurst's
>    suggestion.

Are you planning to send a pull request to arm at kernel.org for this when
you're happy with the state, or should we pick up the patches from the
list?

	Arnd
