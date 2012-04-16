From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 00:26:57 +0530
Subject: [PATCH v4 2/2] regulator: add device tree support for max8997
In-Reply-To: <20120416185153.GH3219@opensource.wolfsonmicro.com>
References: <1332582590-16382-3-git-send-email-thomas.abraham@linaro.org>
 <20120416185153.GH3219@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwSK=T3Fi=mOwjuBciEbG9dD5x8PvqGO3mfF-4qdL50QrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 00:21, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Mar 24, 2012 at 03:19:50PM +0530, Thomas Abraham wrote:
>> Add device tree based discovery support for max8997.
>
> I tried to apply this but it's collided with some other changes in the
> driver which have arrived in the meantime and the rejects were too large
> to fix up. ?I suspect it's mostly just the change in parameters for
> regulator_register(). ?Can you please regenerate against my current
> topic/drivers branch?

Hi Mark,

Sure, I will do redo this patch based on your current 'topic/drivers' branch.

Thanks,
Thomas.
