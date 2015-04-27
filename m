From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 27 Apr 2015 08:36:02 +0200
Subject: [PATCH] ARM: sunxi: dts: Add A10 uarts pin muxing options
In-Reply-To: <20150426161157.GM5627@lukather>
References: <1430043338-28982-1-git-send-email-richard.genoud@gmail.com>
 <20150426161157.GM5627@lukather>
Message-ID: <CACQ1gAgkhxpHxWSRSQe3WNG7hj+EEyS3Yzsnf7TpHQV35jFhGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-26 18:11 GMT+02:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> Hi Richard,
>
> On Sun, Apr 26, 2015 at 12:15:38PM +0200, Richard Genoud wrote:
>> The A10 has 8 uarts, only uart0 and uart1 where filled.
>> This patch adds all the missing uarts(2 to 7) pin muxing to the dtsi.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> It's obviously correct, but I'd rather not add new pinctrl nodes that
> don't have any users so that it doesn't bloat the DT without any
> particular reason.
>
> Feel free to resubmit this patch if one of these nodes become actually
> useful.

Ok, I'll resend-it with only the uarts accessible via the cubieboard
A10 expansion headers.
