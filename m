From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 14:39:46 +0100
Subject: [PATCH 1/3] arm64: arch_timer: Add device tree binding for
 hisilicon-161x01 erratum
In-Reply-To: <1dcfb21a-7417-282e-f187-425d2c148672@huawei.com>
References: <962ea92f-870b-e1d0-5bb7-1a6d66c35122@huawei.com>
 <20161024111608.GG15620@leverpostej>
 <7e839df8-f8f7-3b16-8321-4ff45b6c5884@huawei.com>
 <20161024131617.GJ15620@leverpostej>
 <1dcfb21a-7417-282e-f187-425d2c148672@huawei.com>
Message-ID: <20161024133945.GL15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 09:23:10PM +0800, Ding Tianhong wrote:
> On 2016/10/24 21:16, Mark Rutland wrote:
> > On Mon, Oct 24, 2016 at 08:40:01PM +0800, Ding Tianhong wrote:
> >> On 2016/10/24 19:16, Mark Rutland wrote:
> >>> Is "161x01" the *exact* erratum number, or is the 'x' a wildcard?
> >>
> >> The 'x' is a wildcard, it will cover 161001 to 161601 several numbers,
> > 
> > Given you're using a wildcard, I take it that this is a *part* number?
> 
> Yes, I was doubt how to fix this, should I choose a better erratum number?

Typically, we expect that each vendor has some central database of their
errata, with each having a unique ID.

If Huawei do not have such a database, I do not think that we should
invent an erratum number here.

Thanks,
Mark.
