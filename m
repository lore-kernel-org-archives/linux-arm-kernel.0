From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 22 Aug 2016 20:21:52 +0200
Subject: [PATCH] mmc: Add mmc_force_detect_change_begin / _end functions
In-Reply-To: <831381a3-7cca-1264-29e2-bd40802a815f@redhat.com>
References: <1470488736-11083-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFoTj9=esqaUPiwxLkhCsO98cSDgzdD1phgbXLa7rf6jiw@mail.gmail.com>
 <831381a3-7cca-1264-29e2-bd40802a815f@redhat.com>
Message-ID: <CAPDyKFptVEjy8EQeL0t3xoxLvttHEJdvmmcS4k=8cuJbZEKTxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
> This would also mean the driver's probe function does not end up
> getting called twice which certainly is better :)
>
> I'm not sure I'm familiar enough with the mmc subsys to come
> up with a good implementation of this though, nor when I'll have
> the time to look into this.
>
> Any chance you could make a RFC patch ? I can then test it on
> hardware which actually needs this and bug-fix the code until
> it actually works :)

Sure, I can do that! I keep you in the loop when I post it.

[...]

Kind regards
Uffe
