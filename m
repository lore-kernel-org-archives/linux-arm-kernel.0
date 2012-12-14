From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 14 Dec 2012 11:53:09 +0900
Subject: [PATCH 01/12] regulator: gpio-regulator: Demote GPIO Regulator
 driver to start later
In-Reply-To: <20121213115524.GI27617@gmail.com>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-2-git-send-email-lee.jones@linaro.org>
 <20121210140751.GB6103@opensource.wolfsonmicro.com>
 <20121210142836.GG9362@gmail.com>
 <20121210143141.GG6103@opensource.wolfsonmicro.com>
 <20121213115524.GI27617@gmail.com>
Message-ID: <20121214025307.GB4478@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 11:55:24AM +0000, Lee Jones wrote:

> I understand your logic, hence why I wrote such a lengthy commit
> message. However, I'm not sure I see a logical way around it. Asking
> all users of MMCI to provide a not-regulator to declare that a
> secondary regulator isn't available seems a little unreasonable to me.

> Is there anything else we can do?

Have all the people setting up this secondary regulator explicitly
declare it?
