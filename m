From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 6 Jul 2012 18:29:45 -0600
Subject: [GIT PULL] gpio/omap: final fixes for v3.5
In-Reply-To: <87vci08npt.fsf@ti.com>
References: <87vci08npt.fsf@ti.com>
Message-ID: <CACxGe6v+67PEJrOk6K86WjcU055U_QrPU8e21ppKyn9Rfq36tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Linus W. is handling picking up gpio stuff for me while I'm overloaded with
moving to the UK.

Linus, I typically pull from Kevin instead of applying the patches myself.

g.
 On Jul 6, 2012 5:38 PM, "Kevin Hilman" <khilman@ti.com> wrote:

> Hi Grant,
>
> Here's a couple (hopefully) final OMAP GPIO fixes for v3.5-rc.
>
> Thanks,
>
> Kevin
>
>
> The following changes since commit
> 6b16351acbd415e66ba16bf7d473ece1574cf0bc:
>
>   Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.gitfor_3.5/fixes/gpio-3
>
> for you to fetch changes up to 7b86cef34afceeecf57d4d07f3cfab06f8b60b13:
>
>   gpio/omap: fix invalid context restore of gpio bank-0 (2012-07-03
> 09:41:39 -0700)
>
> ----------------------------------------------------------------
> Grazvydas Ignotas (1):
>       gpio/omap: fix irq loss while in idle with debounce on
>
> Jon Hunter (1):
>       gpio/omap: fix invalid context restore of gpio bank-0
>
>  drivers/gpio/gpio-omap.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120706/8b0ad88f/attachment-0001.html>
