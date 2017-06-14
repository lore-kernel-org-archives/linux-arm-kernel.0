From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jun 2017 10:02:03 -0700
Subject: [PATCH v4 05/11] net: mvmdio: introduce an ops structure
In-Reply-To: <20170614154911.14510-6-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-6-antoine.tenart@free-electrons.com>
Message-ID: <cb758687-8516-3f7e-b28a-2b2400464f4f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 08:49 AM, Antoine Tenart wrote:
> Introduce an ops structure to add an indirection on the is_done
> function, as this is needed to add the xMDIO support later.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
