From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jun 2017 10:02:17 -0700
Subject: [PATCH v4 06/11] net: mvmdio: put the poll intervals in the ops
 structure
In-Reply-To: <20170614154911.14510-7-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-7-antoine.tenart@free-electrons.com>
Message-ID: <232a8c09-1191-fa27-291b-a4d4b49612ad@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 08:49 AM, Antoine Tenart wrote:
> Put the two poll intervals (min and max) in the driver's ops
> structure. This is needed to add the xmdio support later.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
