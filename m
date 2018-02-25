From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 25 Feb 2018 14:13:20 +0200
Subject: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
In-Reply-To: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAHp75VdKDFnrk6i9vBZL2YnqeUH3AaxdZJ_f6ZNOUtnq1pjM3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 4:50 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Also, make MFD_SYSCON 'default y' because some defconfig files may
> rely on someone select's MFD_SYSCON.

I'm not sure this is right thing to do. You basically imply that there
always a user of it.


-- 
With Best Regards,
Andy Shevchenko
