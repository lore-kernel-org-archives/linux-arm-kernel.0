From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 19:08:56 +0530
Subject: [PATCH 2/3] ARM: plat-samsung: use Kconfig choice for debug UART
	selection
In-Reply-To: <20111010133455.GH2451@mudshark.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313530873-24961-2-git-send-email-will.deacon@arm.com>
	<CAJuYYwRPwALAQcvsMPuz8XYsDicCmB52HzZehppUnKqv5itPEQ@mail.gmail.com>
	<20111010122319.GE2451@mudshark.cambridge.arm.com>
	<CAJuYYwQiXSSOQ_FvOn41NSUJ6F4axNbYgV-LfOxhhLvbUz-bMQ@mail.gmail.com>
	<20111010133455.GH2451@mudshark.cambridge.arm.com>
Message-ID: <CAJuYYwToW7Ac+Fh1J0oEBJnXjG93GJBbkL-SOX_jsgk-PWi=BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2011 19:04, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Oct 10, 2011 at 01:35:54PM +0100, Thomas Abraham wrote:
>> There are no difficulties with the original patch. But that was not
>> how Samsung boards have been selecting the low level debug uart port
>> number. The proposed patch tried to maintain the old style.
>>
>> Another point is that Samsung's Exynos4 (and few other SoC's) has a
>> fourth UART port as well. Not that it is used as a debug port
>> currently, but there is no technical limitation in using that as a
>> console port. So that might need 'DEBUG_S3C_UART3' as well.
>
> Tell you what then: let's stick with the original patch for now and then you
> can refactor the Samsung bit in the future if/when you add support for the
> fourth UART. Does that sound OK?

Yes. That sounds fine. Thanks for having a look at the proposed diff.

Regards,
Thomas.

>
> Will
>
