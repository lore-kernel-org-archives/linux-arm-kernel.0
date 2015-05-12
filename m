From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Tue, 12 May 2015 17:18:50 +0200
Subject: [PATCH v4 00/11] drivers: PL011: add ARM SBSA Generic UART support
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150512171850.21019f22@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 May 2015 15:14:44 +0100, Andre Przywara wrote:
> This is the fourth revision of the SBSA UART support series, now
> based on the current tty-next branch.
> Compared to v3 I addressed some comments Jakub had on v3 (thanks for
> the review!). Also since some basic ACPI support for ARM64 is now
> upstream, I include the necessary ACPI binding as a new patch 11
> on top.

Thanks, apart from minor checkpatch --strict warnings it looks good now.
