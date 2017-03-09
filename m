From: davem@davemloft.net (David Miller)
Date: Thu, 09 Mar 2017 13:12:56 -0800 (PST)
Subject: [PATCH v2 0/4] net: thunderx: Miscellaneous fixes
In-Reply-To: <1488890351-18493-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1488890351-18493-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20170309.131256.1923856751370789132.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Tue,  7 Mar 2017 18:09:07 +0530

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> This patch set fixes multiple issues such as IOMMU
> translation faults when kernel is booted with IOMMU enabled
> on host, incorrect MAC ID reading from ACPI tables and IPv6
> UDP packet drop due to failure of checksum validation.

Series applied, thanks.
