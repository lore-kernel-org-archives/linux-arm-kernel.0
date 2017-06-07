From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 7 Jun 2017 12:25:26 -0700
Subject: [PATCH 6/9] net: mvmdio: put the poll intervals in the private
 structure
In-Reply-To: <20170607083810.30922-7-antoine.tenart@free-electrons.com>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
 <20170607083810.30922-7-antoine.tenart@free-electrons.com>
Message-ID: <91aee753-3cd9-78d7-57f7-8b6ed62e23f3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2017 01:38 AM, Antoine Tenart wrote:
> Put the two poll intervals (min and max) in the driver's private
> structure. This is needed to add the xmdio support later.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
