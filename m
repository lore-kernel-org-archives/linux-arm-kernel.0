From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jun 2017 10:03:47 -0700
Subject: [PATCH v4 08/11] net: mvmdio: add xmdio xsmi support
In-Reply-To: <20170614154911.14510-9-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-9-antoine.tenart@free-electrons.com>
Message-ID: <7edbef52-ad00-c59f-3cae-eebd1c823c6f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 08:49 AM, Antoine Tenart wrote:
> This patch adds the xmdio xsmi interface support in the mvmdio driver.
> This interface is used in Ethernet controllers on Marvell 370, 7k and 8k
> (as of now). The xsmi interface supported by this driver complies with
> the IEEE 802.3 clause 45. The xSMI interface is used by 10GbE devices.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Nice!

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
