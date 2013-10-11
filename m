From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Fri, 11 Oct 2013 13:21:19 +0200
Subject: [PATCH 0/1] fix MVEBU GPIO driver bug causing kernel hang
In-Reply-To: <CACRpkda39HGthF6n-T8-Rv0nAug9bxi5sqeyTneKoSS9YmRVmw@mail.gmail.com>
References: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
 <20131002144550.7d28376c@skate>	<524C1C34.5050403@keymile.com>
 <CACRpkda39HGthF6n-T8-Rv0nAug9bxi5sqeyTneKoSS9YmRVmw@mail.gmail.com>
Message-ID: <5257DF2F.5030403@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi LinusW,

what do you mean?
My statement on patch [0/1] contained speculation about a driver which 
is clearly unrelated (the main, generic, orion IRQ controller, which is 
*NOT* what this patch is about). Our discussion with Thomas was about 
this and him explaining how I got the two things confused in my mind.
But the patch, in its real context (the GPIO chip and its interrupt 
handling) should still be sound and needed...
[Patch 0/1] will not be in the commit message anyway...

Thanks,
Gerlando


On 10/11/2013 01:15 PM, Linus Walleij wrote:
> OK I see these comments on patch [0/1] now (how confusing)
> forget what I just said. Patch is dropped.
>
> Yours,
> Linus Walleij
>
