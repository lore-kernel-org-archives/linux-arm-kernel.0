From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:57:20 -0400
Subject: [PATCH 08/16] Generalize handle_ramdisks() and rename to
 handle_cmdline_files().
In-Reply-To: <1376090777-20090-9-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-9-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402240.27484.18.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> The handle_cmdline_files now takes the option to handle as a string,
> and returns the loaded data through parameters, rather than taking
> an x86 specific setup_header structure.  For ARM, this will be used
> to load a device tree blob in addition to initrd images.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
