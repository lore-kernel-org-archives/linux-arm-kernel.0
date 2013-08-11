From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Aug 2013 16:15:52 -0700
Subject: [GIT PULL] Samsung PWM support cleanup
In-Reply-To: <3573853.gDiLaTfgOu@flatron>
References: <3573853.gDiLaTfgOu@flatron>
Message-ID: <20130811231552.GE26757@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 01:32:25AM +0200, Tomasz Figa wrote:
> Hi Olof, Arnd,
> 
> Here is the Samsung PWM cleanup series for you. Particular patches of the
> series involve following modifications:
>  1) fixing up few things in samsung_pwm_timer clocksource driver,
>  2) moving remaining Samsung platforms to the new clocksource driver,
>  3) removing old clocksource driver,
>  4) adding new multiplatform- and DT-aware PWM driver,
>  5) moving all Samsung platforms to use the new PWM driver,
>  6) removing old PWM driver,
>  7) removing all PWM-related code that is not used anymore.
> 
> This is my first pull request ever, so I hope I haven't screwed up anything. ;)

Hi,

If you're using github, then please provide signed tags instead of branches to
pull from, and get your key signed by people. Once it's signed by enough of the
right people, you can sign up for a kernel.org account.

So, I'll be happy to pull this but please provide a tag.


-Olof
