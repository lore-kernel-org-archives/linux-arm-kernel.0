From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 4 Apr 2017 06:14:55 -0000
Subject: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170404054144.GG16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
Message-ID: <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Mon, Apr 03, 2017 at 09:18:12AM +0100, David Woodhouse wrote:
>>
>> You still have typos here.
>
> I'd like to defer to the maintainers whether we prefer MiB over MB.

It is not really a matter of preference. One is correct; the other is not.

While simple errors can of course be forgiven, I cannot understand why you
would deliberately repeat an error once it has been pointed out to you.


-- 
dwmw2
