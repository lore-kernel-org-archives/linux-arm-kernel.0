From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 16 May 2013 18:32:43 +0000 (UTC)
Subject: [PATCH v3 0/6] ARM: OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
In-Reply-To: <1368629322-3170-1-git-send-email-rnayak@ti.com>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1305161831390.21357@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 May 2013, Rajendra Nayak wrote:

> OMAP UART IP needs manual idle modes based on functional state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
> 
> This however breaks in case of device tree because of missing
> idle handling. 
> 
> The series tries to address the issue and tries to remove complete
> sysc handling from serial driver.

These look good to me.  Will queue them for v3.10-rc once they pass local 
testing here.


- Paul
