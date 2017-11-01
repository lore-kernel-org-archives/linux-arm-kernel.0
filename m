From: james.morse@arm.com (James Morse)
Date: Wed, 01 Nov 2017 14:58:33 +0000
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <59F9E119.6040700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

(+CC: Chen Gong and Huang Ying from the git log of [0])

On 31/10/17 15:38, James Morse wrote:
> RFC as I've only build-tested this on x86.

Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?


> Any more testing would be welcome.

('ls /sys/firmware/acpi/tables/', if you have a HEST and EINJ we should be able
to work something out)


Thanks,

James

[0] https://www.kernel.org/doc/Documentation/acpi/apei/einj.txt
