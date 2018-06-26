From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 Jun 2018 09:56:54 +0100
Subject: [PATCH 04/11] ASoC: qdsp6: q6adm: use
 of_platform_populate/depopulate()
In-Reply-To: <20180625180329.GG10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-5-srinivas.kandagatla@linaro.org>
 <20180625180329.GG10876@centauri.lan>
Message-ID: <7912fa0c-b677-3206-51ac-e870c00ff4f8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/06/18 19:03, Niklas Cassel wrote:
> You can remove pdev_routing from struct q6adm,
> since it is no longer in use.
yep, I thought I removed this, but it looks like its still there.
Will fix this in next version.

thanks,
srini
