From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 14:25:06 +0000
Subject: [PATCH V5 1/1] gpio: vf610: add optional clock support
In-Reply-To: <CACRpkdYpmfkB82OLG8ksVO9xFz+uW3OAC1uFwEztCS9CNNZeSg@mail.gmail.com>
References: <CACRpkdaO-cUd7wVksboUU0-qu20aBo370Rio=GkNH11U0CB4Jw@mail.gmail.com>
 <1541426614-17299-1-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdYpmfkB82OLG8ksVO9xFz+uW3OAC1uFwEztCS9CNNZeSg@mail.gmail.com>
Message-ID: <AM0PR04MB4211715479C2EE5BE865DD5280C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> 
> This looks good but doesn't apply to the GPIO "devel" branch for some reason:
> 
> $ git am --signoff dong1.patch
> Applying: gpio: vf610: add optional clock support
> error: patch failed: drivers/gpio/gpio-vf610.c:16
> error: drivers/gpio/gpio-vf610.c: patch does not apply Patch failed at 0001
> gpio: vf610: add optional clock support Use 'git am --show-current-patch' to
> see the failed patch When you have resolved this problem, run "git am
> --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> $ patch -p1 < dong1.patch
> patching file drivers/gpio/gpio-vf610.c
> Hunk #1 succeeded at 7 with fuzz 2 (offset -9 lines).
> Hunk #2 FAILED at 42.
> patch: **** malformed patch at line 136: ev)
> 
> Can you check and rebase/resend?

Thanks for reporting this. I just resent the patch after rebase against gpio tree.
Sorry for the inconvenience.
Please let me know if any issue.

Regards
Dong Aisheng
> 
> Yours,
> Linus Walleij
