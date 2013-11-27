From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 26 Nov 2013 17:33:09 -0800
Subject: [PATCH v2 00/10] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <1385033305-13179-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385033305-13179-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20131127013309.GT9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,

On Thu, Nov 21, 2013 at 01:28:15PM +0200, Ivan Khoronzhuk wrote:
> This series contains fixes and updates of Davinci nand driver in
> order to reuse it for Keystone platform.
> 
> The series is combination of two following series:
> - Davinci nand driver fixes and updates:
>   https://lkml.org/lkml/2013/11/20/271
> - Reuse davinci-nand driver for Keystone arch
>   https://lkml.org/lkml/2013/11/20/315

Can you make sure to consistently change the email $subject for your
patch series? For each of the above, it looks like they are actually
version 2, yet they still just say "[PATCH X/Y]" (not "[PATCH v2 X/Y]").
This makes it harder to parse the history of each series. (And the
combining of two un-versioned patch series adds to the confusion.)

Now, this combined series has a good v2 marking (although at this point,
is it really v3? ...whatever, it doesn't matter). Please continue to
write appropriate $subjects for this and future patch series.

Thanks,
Brian
