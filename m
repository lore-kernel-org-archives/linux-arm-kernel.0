From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 23:34:53 +0100
Subject: [PATCH v3] pinctrl: mvebu: prevent walking off the end of group
 array
In-Reply-To: <1364422304.14860.9.camel@i7.infradead.org>
References: <1363196884-20193-1-git-send-email-jason@lakedaemon.net>
 <1363434272-23172-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdb-CdmzszyixBLGdZjXJXzef26u0qN9xWcrYa3JbAD3Ow@mail.gmail.com>
 <1364422304.14860.9.camel@i7.infradead.org>
Message-ID: <CACRpkdZvz0f-kwS1N=wc438THUuU9_g0VFoy7OYUAiaL8hkBNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 11:11 PM, Woodhouse, David
<david.woodhouse@intel.com> wrote:
> On Wed, 2013-03-27 at 23:06 +0100, Linus Walleij wrote:
>> Is it so critical that it needs to be tagged for stable as well
>> then tell me.
>>
>> If it's non-critical enough to live on for -next then tell me.
>
> I don't think it's critical. It'll probably never trigger in practice.

Thanks, moving it to for-next then...

Yours,
Linus Walleij
