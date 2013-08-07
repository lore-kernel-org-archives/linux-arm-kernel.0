From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 7 Aug 2013 14:09:44 +0100
Subject: [PATCH 10/17] Renames in handle_cmdline_files() to complete
 generalization.
In-Reply-To: <1375847113-24884-11-git-send-email-roy.franz@linaro.org>
References: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
 <1375847113-24884-11-git-send-email-roy.franz@linaro.org>
Message-ID: <20130807130944.GE2515@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Aug, at 08:45:06PM, Roy Franz wrote:
> Rename variables to be not initrd specific, as now the function
> loads arbitrary files.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  drivers/firmware/efi/efi-stub-helper.c |   92 ++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 46 deletions(-)

This looks nice, thanks.

-- 
Matt Fleming, Intel Open Source Technology Center
