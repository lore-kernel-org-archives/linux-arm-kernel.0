From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 31 Oct 2014 10:19:19 +0100
Subject: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
In-Reply-To: <7hoast8eu8.fsf@deeprootsystems.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
 <7hoast8eu8.fsf@deeprootsystems.com>
Message-ID: <CAPDyKFqacYD0HoQMr2CgHKxggUOyC6c9+JWZ3BRrh710E-NmAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2014 21:47, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> To sucessfully probe some devices their corresponding PM domains may
>> need to be powered.
>
> Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
> that working?

Let stay at the discussion of the cover letter patch. I just replied
to this there.

Kind regards
Uffe
