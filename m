From: sbkim73@samsung.com (Sangbeom Kim)
Date: Wed, 01 Aug 2012 17:29:37 +0900
Subject: [alsa-devel] [PATCH 1/2] ASOC: SAMSUNG: Add DT support for i2s
In-Reply-To: <1343218170-30483-2-git-send-email-padma.v@samsung.com>
References: <1343218170-30483-1-git-send-email-padma.v@samsung.com>
 <1343218170-30483-2-git-send-email-padma.v@samsung.com>
Message-ID: <08da01cd6fbf$cd9b5c00$68d21400$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wednesday, July 25, 2012 9:09 PM, Padmavathi Venna wrote:

> Add support for device based discovery.
> 
Currently, I'm reviewing your patch set.
Your patch can support device tree for Samsung's i2s.
But I wonder that Your patch can support non-dt too,
So, Please test your patch on non-dt environment.
It looks unclear handling of clock source.
After code review, I will give you more detail comments,

Thanks,
Sangbeom.
