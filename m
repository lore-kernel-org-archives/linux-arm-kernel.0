From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 30 Oct 2014 12:27:40 +0100
Subject: [PATCH 3/4] PM / Domains: Improve error handling while
 adding/removing devices
In-Reply-To: <7h8ujy5t69.fsf@deeprootsystems.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
 <7h8ujy5t69.fsf@deeprootsystems.com>
Message-ID: <CAPDyKFp=Xky_Cjxkj_gGTzMOQnipPkubjVroAAU1yR9mnnNTKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2014 00:53, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> To improve error handling while adding/removing devices from their PM
>> domains, we need to restructure the code a bit. Let's do this by moving
>> the device specific parts into a separate function.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> This looks like just restructuring, but with these kinds of patches, its
> hard to be sure that it's just refactoring, with no functional changes,
> so it's nice to be clear in the changelog whether there are (meant to
> be) any functional changes.

According to the commit header it's not just restructuring. I will
update the commit message to reflect this better.

Br
Uffe
