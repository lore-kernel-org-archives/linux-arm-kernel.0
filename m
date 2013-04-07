From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 7 Apr 2013 15:13:44 +0300
Subject: [PATCH v9 2/6] remoteproc: Change typo FW_CONFIG to FW_LOADER for
 REMOTEPROC
In-Reply-To: <1364521307-1219-3-git-send-email-rtivy@ti.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-3-git-send-email-rtivy@ti.com>
Message-ID: <CAK=WgbbavgN0pDKvn7f1CrxYKUCpAhVYaEteg=1TVu75RoJuVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 4:41 AM, Robert Tivy <rtivy@ti.com> wrote:
> Fix obvious typo introduced in commit e121aefa7d9f10eee5cf26ed47129237a05d940b
> ("remoteproc: fix missing CONFIG_FW_LOADER configurations").
>
> Signed-off-by: Robert Tivy <rtivy@ti.com>

Applied, thanks.

BTW - we don't usually want to directly cc stable at vger.kernel.org.
Instead we just add a Cc tag in the commit log (fixed before
applying).
