From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Apr 2013 02:08:40 +0900
Subject: [PATCH RESEND] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <516571BC.9030909@samsung.com>
References: <51642dab.e844440a.0ad1.ffffc13f@mx.google.com>
 <201304101459.07263.arnd@arndb.de> <51656D2D.7060004@samsung.com>
 <201304101555.27984.arnd@arndb.de> <516571BC.9030909@samsung.com>
Message-ID: <51756E98.9040606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/13 23:05, Kukjin Kim wrote:
> On 04/10/13 22:55, Arnd Bergmann wrote:
>> On Wednesday 10 April 2013, Sylwester Nawrocki wrote:
>>> Hmm, it turns out we are still actively using some boards based on
>>> Exynos4210 EVT0 SoCs. And since it seems unlikely the patches from
>>> Tomasz [1] adding basic DT support for those will get merged for
>>> 3.10, it would be a bit inconvenient to remove the ATAGS support
>>> now, leaving Exynos4210 Rev. 0 not supported at all.
>>
>> I still have hope to get those included.
>>
> I agree and I asked Tomasz to re-send universal dt patch.
>
Hi Arnd and Olof,

Is it possible to send one more pull-request for this and something like 
dt patches for exynos?

- Kukjin
