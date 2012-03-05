From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Mar 2012 11:15:32 +0100
Subject: [PATCH] pinctrl: resurrect verbose pinmux-pins
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE8619C2@HQMAIL01.nvidia.com>
References: <1330705873-10798-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861978@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861991@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE8619C2@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdYrj2ay=k2MgYOekQtcfbP9FiY5Rju8VznJHrxG81Y7SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2012 at 7:24 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Stephen Warren wrote at Friday, March 02, 2012 10:41 AM:
>> Stephen Warren wrote at Friday, March 02, 2012 10:22 AM:
>> > Linus Walleij wrote at riday, March 02, 2012 9:31 AM:
>> > > From: Linus Walleij <linus.walleij@linaro.org>
>> > >
>> > > This reintroduces the verbosity in the pinmux-pins file, now this
>> > > file will list all pins, their names, owning device (and if it's
>> > > a hog) and also in applicable cases the function and group making
>> > > use of that pin right now.
>> > >
>> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> >
>> > It'd be nice if we could defer this fix until after all the API rework,
>> > because it'll cause all kinds of conflicts otherwise.
>>
>> Oh, I see this patch is in your for-next branch already before I had a chance
>> to comment on it. I guess I'll have write a patch to convert the removed struct
>> type to char*s and rebase on top of it:-(

Mainly because I saw it as a regression fix.

> I take that back. Can we please drop this patch and I'll provide an
> equivalent in my API rework series?

Yeah no problem, if the rest of the v3 patch set is OK I'll just
remove that patch.

Yours,
Linus Walleij
