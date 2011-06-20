From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 20 Jun 2011 10:20:36 +0300
Subject: Problems with semaphores, mutexes, and atomic?
In-Reply-To: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
Message-ID: <BANLkTimDcPWOwEMxdZdPyJdYx7KLGZn2wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 9:39 AM, Dave Hylands <dhylands@gmail.com> wrote:
> Hi,
>
> I wrote a small test module to test semaphores, mutexes and atomic
> increments, and I've tested it with CONFIG_SMP=y with 1 and 2
> processors and with CONFIG_SMP disabled.
>
> My test code can be found here:
> http://svn.hylands.org/linux/test-mutex/test-mutex.c
> (it's about 133 lines long).
yout code is not complete, the DEFINE_SEMAPHORE and DEFINE_SEMAPHORE
definitions are missing
saeed
>
