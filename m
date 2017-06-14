From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jun 2017 10:04:06 -0700
Subject: [PATCH v4 09/11] net: mvmdio: simplify the smi read and write
 error paths
In-Reply-To: <20170614154911.14510-10-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-10-antoine.tenart@free-electrons.com>
Message-ID: <2940b671-3de3-5220-b1fb-496345cc1c19@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 08:49 AM, Antoine Tenart wrote:
> Cosmetic patch simplifying the smi read and write error paths. It also
> align their error paths with the ones of the xsmi functions.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
