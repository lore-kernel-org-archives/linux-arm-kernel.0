From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 26 Oct 2011 14:30:50 +1030
Subject: [PATCH 0/7] Introducing a generic AMP framework
In-Reply-To: <1319536106-25802-1-git-send-email-ohad@wizery.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
Message-ID: <874nywpfkd.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2011 11:48:19 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Modern SoCs typically employ a central symmetric multiprocessing (SMP)
> application processor running Linux, with several other asymmetric
> multiprocessing (AMP) heterogeneous processors running different instances
> of operating system, whether Linux or any other flavor of real-time OS.

OK, I'm not even sure who this should go through, but no objections here
but one:

virtio-spec.txt is a derived document, so I'd prefer that patch to go
through me so I can patch the (LyX) master copy.

Thanks!
Rusty.
