From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 27 Nov 2014 15:07:48 +0900
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <20141120135851.GA32528@linaro.org> <54759041.9080105@hitachi.com>
 <20141126100325.GA9157@linaro.org> <5476120D.9030703@linaro.org>
 <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
Message-ID: <5476BFB4.2020705@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/11/27 3:59), Steve Capper wrote:
> The crash is extremely easy to reproduce.
> 
> I've not observed any missed events on a kprobe on an arm64 system
> that's still alive.
> My (limited!) understanding is that this suggests there could be a
> problem with how missed events from a recursive call to memcpy are
> being handled.

I think so too. BTW, could you bisect that? :)

Thank you,


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
