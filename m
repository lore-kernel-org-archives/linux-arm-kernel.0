From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Jan 2018 19:04:11 +0100
Subject: [resend,
 PATCH v1] ARM: pxa/raumfeld: use PROPERTY_ENTRY_U32() directly
In-Reply-To: <20180129173708.59097-1-andriy.shevchenko@linux.intel.com> (Andy
 Shevchenko's message of "Mon, 29 Jan 2018 19:37:08 +0200")
References: <20180129173708.59097-1-andriy.shevchenko@linux.intel.com>
Message-ID: <87po5s8rtw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Instead of using PROPERTY_ENTRY_INTEGER() with explicitly supplied type,
> use PROPERTY_ENTRY_U32() dedicated macro.
>
> It will help modify internals of built-in device properties API.
>
> No functional change intended.
>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to pxa/for-next branch, thanks.

Cheers.

--
Robert
