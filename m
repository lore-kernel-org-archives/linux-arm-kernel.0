From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 20:10:49 +0000
Subject: [PATCH 7/8] s3c-hsudc: use release_mem_region instead of
 release_resource
In-Reply-To: <201112191942.52629.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
 <201112191942.52629.heiko@sntech.de>
Message-ID: <20111220201049.GB2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 07:42:52PM +0100, Heiko St?bner wrote:
> As the memory region is requested through request_mem_region
> use the correct paired method to release it in the error path
> and don't go "beneath the API" as pointed out by Russel King.

Please correct the spelling, thanks.
