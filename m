From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 8 Dec 2015 23:00:13 -0300
Subject: [RESEND PATCH] modpost: don't add a trailing wildcard for OF
 module aliases
In-Reply-To: <20151208151149.50ee68b41c5b9bc833eb0c2b@linux-foundation.org>
References: <1449612813-27004-1-git-send-email-javier@osg.samsung.com>
 <20151208151149.50ee68b41c5b9bc833eb0c2b@linux-foundation.org>
Message-ID: <56678B2D.1040905@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On 12/08/2015 08:11 PM, Andrew Morton wrote:
> On Tue,  8 Dec 2015 19:13:32 -0300 Javier Martinez Canillas <javier@osg.samsung.com> wrote:

[snip]

>>
>> I sent this patch before [0] but was never picked. MAINTAINERS doesn't
>> say who should manage patches to file2alias so maybe I didn't add the
>> right person to the cc list.
> 
> z:/usr/src/git26> perl scripts/get_maintainer.pl -f scripts/mod 
> Rusty Russell <rusty@rustcorp.com.au> (commit_signer:18/27=67%)
>

Yes, I use get_maintainer.pl but usually with the --no-git-fallback since
the --git-fallback option tends to be too noisy and people complain that
are cc'ed on random patches just because they touched a file in the past.

IOW, there is no way to know only by looking at get_maintainer.pl output
if Rusty has only made a lot of changes to that repo or if he acts as a
maintainer (i.e: picks patches and send pull requests).

For these cases, is good to have a proper entry in MAINTAINERS.
 
>> Documentation/development-process/5.Posting says that if there is no
>> obvious maintainer, then Andrew Morton is often the patch target so
>> I'm re-sending to him.
> 
> Yep.  If I don't handle the particular patch, I know who does ;)
>

I see that you picked the patch already, thanks a lot for your help!

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
