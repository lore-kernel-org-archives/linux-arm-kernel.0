From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 09 Nov 2012 17:58:13 +0100
Subject: pxa27x_keypad status
In-Reply-To: <CA+E=qVc37ZB-mfbJxFVWCVsOC_4Rx7bjzMMkouiTNhhEqATnsw@mail.gmail.com>
 (Vasily Khoruzhick's message of "Mon, 5 Nov 2012 21:48:14 +0300")
References: <87fw4nvqfs.fsf@free.fr>
 <CA+E=qVc37ZB-mfbJxFVWCVsOC_4Rx7bjzMMkouiTNhhEqATnsw@mail.gmail.com>
Message-ID: <87fw4iu316.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> On Mon, Nov 5, 2012 at 9:45 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi Robert,
>
> 3.7-rc2 works for me except suspend/resume issue (does not work after resume)
> I've just reverted 6ce34a5fb4955fac1eebe080e1c2784bc8710449 as
> temporary workaround.

OK, checked on another of my devices. You're right, it does work.
Conclusion: one device with broken keypad hardware :(

Cheers.

-- 
Robert
