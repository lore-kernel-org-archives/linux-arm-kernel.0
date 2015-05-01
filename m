From: davem@davemloft.net (David Miller)
Date: Thu, 30 Apr 2015 22:30:28 -0400 (EDT)
Subject: [PATCH net-next 1/1] drivers: net: xgene: fix kbuild warnings
In-Reply-To: <1430435357-20679-1-git-send-email-isubramanian@apm.com>
References: <1430435357-20679-1-git-send-email-isubramanian@apm.com>
Message-ID: <20150430.223028.1104963892034684806.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Thu, 30 Apr 2015 16:09:17 -0700

> Fixed the following kbuild warnings:
> 1. unused variable 'of_id'
> 2. buffer overflow 'ring_cfg' 5 <= 5
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Applied.
