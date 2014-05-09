From: menon.nishanth@gmail.com (menon.nishanth at gmail.com)
Date: Fri, 9 May 2014 12:17:23 -0500
Subject: [PATCH 1/3] arm64: Enable OPP
In-Reply-To: <20140509171120.GS12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
 <20140509171120.GS12304@sirena.org.uk>
Message-ID: <CAGo_u6oL06G7jk8_X-SH73oWCAHX5vTj7ViC1AyaDhDLJEvWmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 9, 2014 at 12:11 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 09, 2014 at 12:02:12PM -0500, menon.nishanth at gmail.com wrote:
>> On Fri, May 9, 2014 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Some of the generic drivers used on ARM class systems use OPP so allow it
>> > to be selected in Kconfig. No code is required for this, it is not clear
>> > to me why there is config for this option.
>
>> If you mean why we have ARCH_HAS_OPP,
>> http://lists-archives.com/linux-kernel/27401148-pm-hide-opp-configuration-when-socs-do-not-provide-an-implementation.html
>
> That's for the user visible symbol but OPP is also enableable via select
> - the fix here may be to remove both the visibility check and the
> dependency.
That is reasonable.
Regards,
Nishanth Menon
