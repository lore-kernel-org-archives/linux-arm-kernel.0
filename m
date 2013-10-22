From: dave.long@linaro.org (David Long)
Date: Tue, 22 Oct 2013 19:56:20 -0400
Subject: [PATCH v2 02/13] uprobes: allow ignoring of probe hits
In-Reply-To: <1641249240.11471136.1382441151287.JavaMail.root@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-3-git-send-email-dave.long@linaro.org>
 <20131019170214.GA8324@redhat.com> <5265F4EB.2060803@linaro.org>
 <1641249240.11471136.1382441151287.JavaMail.root@redhat.com>
Message-ID: <526710A4.9010705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/13 07:25, Oleg Nesterov wrote:
> Sorry for top-posting/formatting,
>
> Do you mean arch_uprobe_skip_sstep() ?
>
> Yes, this __weak is wrong, already fixed in my tree. See
> http://marc.info/?l=linux-mips&m=138132052022388&w=2
>

That was one I was looking at, but it seemed to me a general opportunity 
for runtime failures in the kernel that could have been detected at link 
time.  But that's a topic for discussion elsewhere I should think.

-dl
