From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 15 May 2018 11:46:41 +0200
Subject: [PATCH 27/61] media: platform: s5p-mfc: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-28-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-28-wsa+renesas@sang-engineering.com>
 <CGME20180515094647epcas1p49b3c5d47dcedd034aec9589aab473cc0@epcas1p4.samsung.com>
Message-ID: <0684984f-6e52-5e91-f6bb-1084c588e1b4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
