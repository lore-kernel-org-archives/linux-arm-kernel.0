From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 15:58:03 +0100
Subject: [PATCH V2 08/12] dtb: amd: Add PERF CCN-504 device tree node
In-Reply-To: <1454954357-8395-9-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1454954357-8395-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <3090961.S0JY5ma2pB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 11:59:13 Suravee Suthikulpanit wrote:
> +               /* Perf CCN504 PMU */
> +               ccn: ccn at 0xe8000000 {
> 

The address is wrong, please remove the '0x'.

	Arnd
