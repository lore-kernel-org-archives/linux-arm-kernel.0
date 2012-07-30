From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 07:54:26 +0100
Subject: [PATCH 10/18] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <20120729204516.GJ4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-11-git-send-email-lee.jones@linaro.org>
 <20120729204516.GJ4384@opensource.wolfsonmicro.com>
Message-ID: <50162FA2.4010009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/12 21:45, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 01:45:54PM +0100, Lee Jones wrote:
>> The current kernel commandline for ux500 based devices includes
>> hard-coded allocations for things like mali and hwmem, which
>> actually run over lowmem. Here we enable highmem in order to
>> avoid memory corruption errors.
>
> This appears to be at best tangentially related to the rest of the
> series, are you sure it shouldn't be being sent separately as a bugfix?

Yes, it should. I'll shift it.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
