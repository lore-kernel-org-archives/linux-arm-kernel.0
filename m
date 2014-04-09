From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Apr 2014 20:19:33 +0100
Subject: [PATCH v2] ARM: uprobes need icache flush after xol write
In-Reply-To: <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
 <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
Message-ID: <20140409191932.GB16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 12:13:56PM -0700, Victor Kamensky wrote:
> Fair enough. Can do that, as well as address Dave's comment about
> checkpatch.
> 
> But before I do that let's reach some conclusion wrt latest Russell's
> remarks about copy_{to,from}_user_page usage in uprobes. It is bigger
> question covering more than ARM issue and possibly having bigger
> implication on uprobes design. I have some comments/thoughts about
> it, but since I am not uprobes maintainer, will wait for you to address
> it first.

I encourage folk to read this thread:

http://lkml.iu.edu//hypermail/linux/kernel/1404.1/00725.html

and involve David in the loop - I suspect you need to sell whatever
solution you agree on to David (as one of the other arch maintainers)
as well.  Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
