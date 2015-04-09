From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 9 Apr 2015 11:16:32 -0700
Subject: [RFC PATCH] ARM: debug: Add prompt for FRAME_POINTER to
 Kconfig.debug
In-Reply-To: <20150409074558.GT12732@n2100.arm.linux.org.uk>
References: <1428537883-19622-1-git-send-email-gregory.0xf0@gmail.com>
 <20150409074558.GT12732@n2100.arm.linux.org.uk>
Message-ID: <CADtm3G6HOikdeXSKjtP61mTRCXpJ6XX90+g+jrCxEojN9=D_XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 9, 2015 at 12:45 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 08, 2015 at 05:04:43PM -0700, Gregory Fong wrote:
>> Without a prompt string, it is impossible to disable FRAME_POINTER on
>> ARM. It will simply set the default value anytime you run 'make'.
>
> Have you read the comment above it?

Yes!  It says that you'll kill those who disable the option, but
that's not itself a reason to be completely unable to turn it off.

Just think of it as a good way to increase your reputation as a bounty hunter ;)

Seriously though, I agree it's a terrible idea to turn this off in
general, but really that's not a reason to make it impossible, as it
does still have value in very specific cases.  You can still disable
CONFIG_BUG, for example.
