From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Apr 2012 13:02:28 +0200
Subject: [PATCH 1/7] ARM: ux500: New DT:ed snowball_platform_devs for
 one-by-one device enablement
In-Reply-To: <4F83FCC5.9040103@linaro.org>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-2-git-send-email-lee.jones@linaro.org>
 <CACRpkdYVxQjJCQO3YY9=Orv-vLJJBzs4APPhCMHjR-3AGAbshg@mail.gmail.com>
 <4F83FCC5.9040103@linaro.org>
Message-ID: <CACRpkdZi1oV2gyi06qH4nxXDOPMgCz6V_fFpLo-L3xiK8MHXYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 11:26 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Nothing is unused. When DT is disabled snowball_platform_devs will be used
> to add the platform devices. This is, and will remain fully populated for
> non-DT boots. The DT'ed version will decrease in size until the final
> element is removed along with the definition.

OK then..

> I have ran this past Arnd, who thought this was a good idea. It's only a
> temporary solution which well aide us in enabling devices spanned over
> multiple submissions, rather than attempting to enable everything in a
> single patch-set - which isn't going to happen.

Sure so let's say that I add this patch immediately before the first patch
removing atleast *one* of the entries, because until then it is certainly
not needed.

Yours,
Linus Walleij
