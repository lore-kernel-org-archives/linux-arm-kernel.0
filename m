From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:57:27 -0400
Subject: [PATCH 09/16] Renames in handle_cmdline_files() to complete
 generalization.
In-Reply-To: <1376090777-20090-10-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-10-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402247.27484.19.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> Rename variables to be not initrd specific, as now the function
> loads arbitrary files.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
