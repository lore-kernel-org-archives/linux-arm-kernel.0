From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 15:04:56 +0000
Subject: [PATCH 6/7] s3c-hsudc: Add regulator handling
In-Reply-To: <201112191427.07682.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
 <201112191427.07682.heiko@sntech.de>
Message-ID: <20111220150456.GF29727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 02:27:07PM +0100, Heiko St?bner wrote:
> The udc has three supplies: vdda (3.3V), vddi (1.2V) and vddosc (1.8-3.3V).
> Turn these on and off on start and stop calls.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
