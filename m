From: davem@davemloft.net (David Miller)
Date: Thu, 09 Oct 2014 18:56:44 -0400 (EDT)
Subject: [PATCH v3 0/6] Add 10GbE support to APM X-Gene SoC ethernet driver
In-Reply-To: <1412826861-32208-1-git-send-email-isubramanian@apm.com>
References: <1412826861-32208-1-git-send-email-isubramanian@apm.com>
Message-ID: <20141009.185644.1973399214870399180.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Wed,  8 Oct 2014 20:54:15 -0700

> Adding 10GbE support to APM X-Gene SoC ethernet driver.
> 
> v3: Address comments from v2
> * dtb: changed to use all-zeros for the mac address
> 
> v2: Address comments from v1
> * created preparatory patch to review before adding new functionality
> * dtb: updated to use tabs consistently
> 
> v1:
> * Initial version

This does not apply to my current tree, in particular the DT files
get rejects.
