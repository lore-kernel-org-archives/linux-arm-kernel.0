From: dave.long@linaro.org (David Long)
Date: Fri, 15 Nov 2013 10:16:50 -0500
Subject: [PATCH v2 10/13] kprobes: Remove uneeded kernel dependency on
 struct arch_specific_insn
In-Reply-To: <5285F62D.5010407@hitachi.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-11-git-send-email-dave.long@linaro.org>
 <1384362833.3392.42.camel@linaro1.home> <52842F2C.1030701@hitachi.com>
 <1384438551.3388.78.camel@linaro1.home> <52853389.7080105@linaro.org>
 <5285F62D.5010407@hitachi.com>
Message-ID: <52863AE2.9010005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/13 05:23, Masami Hiramatsu wrote:
> I see. I'd just like to suggest you that your improvement on ONE arch
> can also be useful idea for the other archs. In that case, there would be
> better, more efficient way to do that.
> Since we are on the same (or, next) track, we can learn many things each other. :)
>
> Thank you,
>

I'd like to suggest there is still no reason not to take the current 
work (with suggested changes), which interested parties can then further 
adapt for supporting other/multiple architectures.  There is virtually 
no new architecture-specific code that would have to be redone later. 
Additionally, it's not clear to me how useful instruction interpretation 
is to any other architecture.  We are doing this only because 32-bit ARM 
does not support single-stepping.

-dl
