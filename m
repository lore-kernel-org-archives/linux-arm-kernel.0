From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Feb 2017 13:11:36 +0100
Subject: [PATCH] [media] staging: bcm2835: mark all symbols as 'static'
In-Reply-To: <CAK8P3a0TMW+GrdbLPqBDKyqXaP-LvYkGfD5bfcW4W6dXMnHy1A@mail.gmail.com>
References: <20170202113436.690145-1-arnd@arndb.de>
 <CAK8P3a0TMW+GrdbLPqBDKyqXaP-LvYkGfD5bfcW4W6dXMnHy1A@mail.gmail.com>
Message-ID: <CAK8P3a3W0q8NjZdY9Wc328o6dCwkkod1k0zFqYtrkuvXwO_5dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 1:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Feb 2, 2017 at 12:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> I got a link error in allyesconfig:
>> Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Please disregard this patch version, it's broken.

Too late, I see it's already applied, I'll send a follow-up to revert
the first hunk.

    Arnd
