From: xander.huff@ni.com (Xander Huff)
Date: Fri, 08 May 2015 09:53:24 -0500
Subject: [PATCH 1/6] ARM: Zynq: DT: Disable xadc node by default in
 zynq-7000.dtsi
In-Reply-To: <20150507223635.GH8150@xsjsorenbubuntu>
References: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
 <20150507223635.GH8150@xsjsorenbubuntu>
Message-ID: <554CCDE4.9090904@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/7/2015 5:36 PM, S?ren Brinkmann wrote:
> For peripherals that might not be pinned out on a board. But the XADC is
> always present in Zynq and can be used to read the temperature in any
> case.
OK, this makes sense, thanks!

Please disregard this patch set

-- 
Xander Huff
Staff Software Engineer
National Instruments
