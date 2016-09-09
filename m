From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 09 Sep 2016 10:00:35 -0700
Subject: next build: 143 builds: 2 failed, 141 passed, 2 errors,
 2 warnings (next-20160909)
In-Reply-To: <2582793.W17ckCts1B@wuerfel> (Arnd Bergmann's message of "Fri, 09
 Sep 2016 13:18:31 +0200")
References: <57d26402.eeb8c20a.ba0e2.8bbb@mx.google.com>
 <2582793.W17ckCts1B@wuerfel>
Message-ID: <m2oa3xgg98.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday, September 9, 2016 12:25:54 AM CEST kernelci. org bot wrote:
>> next build: 143 builds: 2 failed, 141 passed, 2 errors, 2 warnings (next-20160909)
>
> This is pretty good, here is what's left:
>
>> rpc_defconfig (arm) ? FAIL, 1 error, 0 warnings, 0 section mismatches
>> 
>> Errors:
>>     fs/fat/dir.c:758:424: internal compiler error: Segmentation fault
>
> Could we please update the gcc build on kernelci.org from "Linaro GCC 5.3-2016.02"
> to the following version (Linaro GCC 5.3-2016.05) or later?

I finally found the release tarballs for Linaro toolchains (the "latest"
link on the linaro releases was stale, and pointing to 2016.02).

So it's now 5.3-2016.05 on all the kCI builders.

Kevin
