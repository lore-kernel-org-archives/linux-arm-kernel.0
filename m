From: olof@lixom.net (Olof Johansson)
Date: Thu, 14 Apr 2016 11:49:11 -0700
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <20160414182520.GA8663@sirena.org.uk>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
 <CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
 <20160414182520.GA8663@sirena.org.uk>
Message-ID: <CAOesGMiqpm1TjiOpCv+kYp60FrhRhs3Leomv5KyySk8k15YFNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 11:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 14, 2016 at 11:02:15AM -0700, Olof Johansson wrote:
>
>> Switch the default from y to n on ARM64 (or default !ARM64) and I'll
>> be happy to ack it.
>
>> Mostly because it doesn't make sense for people building their own
>> configs for embedded systems to get it turned on by default. Anyone
>> running on a server is likely to clone an existing distro config in
>> the first place.
>
> I can send a followup patch for that (I actually already wrote that
> after the discussion with Will), but I do think we should enable it in
> defconfig for the testing.

That sounds good.

So, to clarify: a follow-up patch (to arm at kernel.org) to turn on ACPI
in arm64 defconfig, and a respin of this patch to change the default.


-Olof
