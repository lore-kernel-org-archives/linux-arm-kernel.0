From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 23:06:59 +0100
Subject: [PATCH v3] pinctrl: mvebu: prevent walking off the end of group
 array
In-Reply-To: <1363434272-23172-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1363196884-20193-1-git-send-email-jason@lakedaemon.net>
 <1363434272-23172-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdb-CdmzszyixBLGdZjXJXzef26u0qN9xWcrYa3JbAD3Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 16, 2013 at 12:44 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: David Woodhouse <dwmw2@infradead.org>
>
> While investigating (ab)use of krealloc, David found this bug.  It's
> unlikely to occur, but now we detect the condition and error out
> appropriately.
>
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

OK this v2 version applied for fixes...

Is it so critical that it needs to be tagged for stable as well
then tell me.

If it's non-critical enough to live on for -next then tell me.

Yours,
Linus Walleij
