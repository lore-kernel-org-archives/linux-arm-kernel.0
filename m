From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 29 Aug 2013 21:47:45 +0100
Subject: [PATCH v3 2/6] iio: at91: introduce the multiple compatible string
 for different IPs.
In-Reply-To: <20130828080200.GM2695@lukather>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-3-git-send-email-josh.wu@atmel.com>
 <20130828080200.GM2695@lukather>
Message-ID: <521FB371.1030005@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/13 09:02, Maxime Ripard wrote:
> Hi Josh,
> 
> On Tue, Aug 27, 2013 at 07:28:48PM +0800, Josh Wu wrote:
>> As use the multiple compatible string, we can remove hardware register in dt.
>> 
>> CC: devicetree at vger.kernel.org Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> It's ok for me. You can add my Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
I've assumed for such and obviously good change that none of the devicetree
maintainers need to give an ack and applied this to the togreg branch of iio.git

Thanks,

Jonathan
> 
> Thanks! Maxime
> 
