From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 11 Jun 2014 20:32:15 +0200
Subject: [PATCH 00/24] PM / Domains: Generic OF-based support and cleanups
In-Reply-To: <7hlht3gvas.fsf@paris.lan>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <7hlht3gvas.fsf@paris.lan>
Message-ID: <CAJZ5v0gcHSGf5DBYC-KLtOCveo---vQdSmdUKCqU7pNMKcXbww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 8:23 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Parts of this patchset has been posted earlier. To be able to smoothly continue
>> my work in re-factoring genpd I have collected patches into this patchset.
>>
>> The complete patchset is available at the linux-pm_linux-next_genpd branch at:
>> git.linaro.org/people/ulf.hansson/linux-2.6.git
>> This branch is based upon Rafael's linux-pm tree's linux-next branch.
>>
>> And important note. There are dependencies througout this patchset, which means
>> the all need to go together. I suggest we use Rafael's tree, thus I seek for
>> acks from the affected ARM SoC maintainers.
>
> At least on the surface, there are at least 3 separate series going on
> here
>
> 1) DT support for genpd
> 2) various genpd cleanups
> 3) ux500 support
>
> Clearly they are related, but it would be easier to review if a large
> series like this is broken up into smaller series where the cover
> letters describe the dependencies between them

Agreed.

And if they are sent in such an order that the bits the rest depends on
go first and are settled before the next series is even submitted.

Rafael
