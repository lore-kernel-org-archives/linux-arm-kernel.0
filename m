From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 11 Jun 2013 12:33:17 +0200
Subject: [PATCH 0/2 v2] Bugfixes for Tegra memory controllers.
In-Reply-To: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
References: <1370945479-2917-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20130611103316.GC932@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 01:11:17PM +0300, Tuomas Tynkkynen wrote:
> Hi,
> 
> Here's two simple bugfixes for the Tegra memory controllers.
> 
> v2: Fix a dumb bug in the bit masking.
> 
> Tuomas Tynkkynen (2):
>   memory: tegra20-mc: Fix hang in IRQ handler.
>   memory: tegra30-mc: Fix IRQ handler.
> 
>  drivers/memory/tegra20-mc.c | 5 ++++-
>  drivers/memory/tegra30-mc.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)

Both patches:

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

On a side-note, the subject format looks a bit strange and my guess is
you had to manually edit it to insert "v2". git can do it for you when
you generate the patch series using:

	git format-patch --subject-prefix='PATCH v2'

That'll also automatically add the v2 to all individual patches instead
of just the cover-letter.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/82711ac0/attachment.sig>
