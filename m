From: keescook@chromium.org (Kees Cook)
Date: Mon, 28 Jul 2014 16:29:31 -0700
Subject: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
In-Reply-To: <53D68F91.4000106@zytor.com>
References: <cover.1405992946.git.luto@amacapital.net>
 <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
 <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
 <53D68F91.4000106@zytor.com>
Message-ID: <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>
>> It looks like patches 1-4 have landed here:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> hpa, what's the route forward for the x86 part?
>>
>
> I guess I should discuss this with Kees to figure out what makes most
> sense.  In the meantime, could you address Oleg's question?

Since the x86 parts depend on the seccomp parts, I'm happy if you
carry them instead of having them land from my tree. Otherwise I'm
open to how to coordinate timing.

-Kees

>
>         -hpa
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Kees Cook
Chrome OS Security
