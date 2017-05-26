From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 May 2017 22:57:40 +0200
Subject: [stable backport PATCH] usercopy: Adjust tests to deal with
 SMAP/PAN
In-Reply-To: <CAGXu5jLa2QEcg9DcKtkqxL1fCzGznhg586-ZDOoXzjF8z0FE1Q@mail.gmail.com>
References: <20170526204040.1953914-1-arnd@arndb.de>
 <CAGXu5jLa2QEcg9DcKtkqxL1fCzGznhg586-ZDOoXzjF8z0FE1Q@mail.gmail.com>
Message-ID: <CAK8P3a1HSEndzLZ5a0e6DV+pGhhyD5gHCudtkC8BQ66P4_xccw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 10:53 PM, Kees Cook <keescook@chromium.org> wrote:
>> +
>> +       value = 0x5a;
>
> I don't think this "value" bit wanted, but it should be harmless.
>

Right, that should not be there, it came from a different patch.
I've sent a new version of the backport now. Thanks for taking a look.

       Arnd
