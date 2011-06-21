From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 21 Jun 2011 12:30:21 +0300
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <BANLkTimn-THKipuQVHLA9i3QSoO5RTqMtA@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<BANLkTimn-THKipuQVHLA9i3QSoO5RTqMtA@mail.gmail.com>
Message-ID: <BANLkTin3DeTK96nBo2qJGeg5NFZnDPSyxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 10:50 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> root at omap4430-panda:~# cat /debug/remoteproc/omap-rproc.1/state
> running (2)

At this point, the two remote M3 cores also start dumping trace logs to
shared memory buffers, which are exposed by debugfs entries:

root at omap4430-panda:~# cat /debug/remoteproc/omap-rproc.1/trace0
CORE0 starting..
...

root at omap4430-panda:~# cat /debug/remoteproc/omap-rproc.1/trace1
CORE1 starting..
...
