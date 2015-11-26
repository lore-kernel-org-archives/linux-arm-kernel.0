From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 26 Nov 2015 11:44:01 +0200
Subject: [PATCH] remoteproc/wkup_m3: Use MODULE_DEVICE_TABLE to export
 alias
In-Reply-To: <1442406774-13260-1-git-send-email-d-gerlach@ti.com>
References: <1442406774-13260-1-git-send-email-d-gerlach@ti.com>
Message-ID: <CAK=Wgbb_y=bAG6fPqv-w3Dd85jqAyGL25UMjrFQbwWzNk-awjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 3:32 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Use MODULE_DEVICE_TABLE with wkup_m3_rproc_of_match so the module alias
> is exported and the wkup_m3_rproc driver can automatically probe.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Applied to remoteproc-next, thanks.
