From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 24 Apr 2017 14:28:15 -0700
Subject: [PATCH] Mangled urls fixed (was... Re: linux-next: manual merge of
 the pm tree with the arm-soc tree)
In-Reply-To: <CAK8P3a1mPgM4XmS398DPsSbyCyD=12xQfUrF_HRqyd52_21o7Q@mail.gmail.com>
References: <20170421105405.6a690b35@canb.auug.org.au>
 <CAK8P3a3kHO1NZFJXvDwWO625aEmXoo2540FRKe+YYzoYE9NCSg@mail.gmail.com>
 <4b58d5ab-c924-97af-728f-b9f524e62a53@oracle.com>
 <CAK8P3a0cVMt3y_oYH70V-ekPvUMeeBApSvybpRftSupzYy1FWQ@mail.gmail.com>
 <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
 <CAK8P3a1mPgM4XmS398DPsSbyCyD=12xQfUrF_HRqyd52_21o7Q@mail.gmail.com>
Message-ID: <664dcaaf-3eee-3292-9489-912baf5c393d@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 4/21/17 2:44 PM, Arnd Bergmann wrote:
> On Fri, Apr 21, 2017 at 11:02 PM, santosh.shilimkar at oracle.com

[...]

> Ok, good, thanks for checking! They are however the commits that
> contain the silly https://urldefense.proofpoint.com URLs. Can you
> send a follow-up patch to fix these and use the regular https://urldefense.proofpoint.com/v2/url?u=http-3A__www.ti.org&d=DwIBaQ&c=RoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=XBn1JQGPwR8CsE7xpP3wPlG6DQU7qw8ym65xieNZ4hY&m=vFHOEb7p2FxbH00YRQq4WnRiu2BKHADn0gl6e6DoNFQ&s=7mfiIp2Ywy9_ppWKjEGlrswiKRndv8_I7zGVF9uyT0w&e=
> URL that is in linux-next?
>
If not late can you please apply the top patch from below head
which fixes the mangled urls. Let me know if you want me to
create tag for the same.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
for_4.12/soc-pmdomain-p2

Regards,
Santosh
