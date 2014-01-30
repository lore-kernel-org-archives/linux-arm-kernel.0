From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jan 2014 15:09:25 +0100
Subject: [RFC PATCH V3 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
In-Reply-To: <1390599168-13150-3-git-send-email-tinamdar@apm.com>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
 <1390599168-13150-3-git-send-email-tinamdar@apm.com>
Message-ID: <201401301509.26080.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 January 2014, Tanmay Inamdar wrote:
> +               pcie3: pcie at 1f500000 {
> +                       reg-names = "csr", "cfg";
> +                       ranges = <0x01000000 0x0 0x00000000 0xa0 0x00000000 0x0 0x00010000  /* mem */
> +                                 0x02000000 0x0 0x10000000 0xa0 0x10000000 0x0 0x80000000>; /* io  */

The two comments are wrong for this instance.

	Arnd
