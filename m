From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 9 Apr 2014 20:24:59 +0200
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140409161826.GW16119@n2100.arm.linux.org.uk>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk> <5343F42D.5090205@linaro.org>
 <20140408133039.GH16119@n2100.arm.linux.org.uk>
 <20140408152735.GA30076@redhat.com>
 <20140408154117.GI16119@n2100.arm.linux.org.uk>
 <20140409161826.GW16119@n2100.arm.linux.org.uk>
Message-ID: <20140409182459.GA380@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09, Russell King - ARM Linux wrote:
>
> I floated a patch to remove flush_icache_user_range() to the architecture
> maintainers, giving the background to how this came about.  I received the
> following reply from David Miller:
>
> > ptrace() accesses (via __access_remote_vm()) already use an existing
> > helper function for these sorts of situations, in the form of
> > copy_{to,from}_user_page().  I would suggest that uprobes uses that
> > as well.
>
> I think this is a very valid point, and echo's my point.

Well. So far I disagree, but let me reply tomorrow.

Sorry, right now I can't even read this thread.

Oleg.
