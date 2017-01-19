From: keescook@chromium.org (Kees Cook)
Date: Thu, 19 Jan 2017 14:08:12 -0800
Subject: [RFC][PATCH 0/2] Better hardening names
In-Reply-To: <1484789346-21012-1-git-send-email-labbott@redhat.com>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
Message-ID: <CAGXu5j+KA_+OxBo_fFO+YoZDyNYTCttRh06868o5-DAz53D30Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 5:29 PM, Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> It's come up previously that CONFIG_DEBUG_SET_MODULE_RONX and
> CONFIG_DEBUG_RODATA are not accurate names, mostly they should not have the
> word 'debug' in them. This series attempts to change the names to something
> a bit more descriptive and indicative of what they are actually used for these
> days.
>
> I marked this RFC for
> - Bike shedding purposes.
> - A discussion of what defaults should be. The way I did the refactoring, both
>   options are default y. I'd appreciate comments if there is a better approach.
> - Approach to split this up into more sub patches to make review/merging easier?
>   Or maybe it's fine.
>
> Quickly tested on arm/arm64/x86.
>
> Thanks,
> Laura
>
> Laura Abbott (2):
>   security: Change name of CONFIG_DEBUG_RODATA
>   security: Change name of CONFIG_DEBUG_SET_MODULE_RONX

Some day I'll quit reading my email backwards. :) I see you've got
MODULE_RONX renamed too here, please ignore my comment about needing
it "too". :)

-Kees

-- 
Kees Cook
Nexus Security
