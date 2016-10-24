From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 14:16:18 +0100
Subject: [PATCH 1/3] arm64: arch_timer: Add device tree binding for
 hisilicon-161x01 erratum
In-Reply-To: <7e839df8-f8f7-3b16-8321-4ff45b6c5884@huawei.com>
References: <962ea92f-870b-e1d0-5bb7-1a6d66c35122@huawei.com>
 <20161024111608.GG15620@leverpostej>
 <7e839df8-f8f7-3b16-8321-4ff45b6c5884@huawei.com>
Message-ID: <20161024131617.GJ15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 08:40:01PM +0800, Ding Tianhong wrote:
> On 2016/10/24 19:16, Mark Rutland wrote:
> > Is "161x01" the *exact* erratum number, or is the 'x' a wildcard?
> 
> The 'x' is a wildcard, it will cover 161001 to 161601 several numbers,

Given you're using a wildcard, I take it that this is a *part* number?

Thanks,
Mark.
