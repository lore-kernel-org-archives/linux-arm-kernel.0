From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 26 Apr 2018 16:29:29 -0700
Subject: [PATCH 04/61] bus: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-5-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-5-wsa+renesas@sang-engineering.com>
Message-ID: <11bc8504-d32a-36fc-0a51-569fff3c4ee2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2018 07:05 AM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Looks reasonable, would you want to use dev_set_drvdata() while we are
it? That would bring more consistency given your proposed change.

Thanks!
-- 
-- 
Florian
