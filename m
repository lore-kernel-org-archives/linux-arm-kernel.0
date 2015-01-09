From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 09 Jan 2015 17:36:48 +0000
Subject: [PATCH v2 1/3] dtb: xgene: fix: Backward compatibility with
 older firmware
In-Reply-To: <1420819166.21186.38.camel@citrix.com>
References: <1415044796-5081-1-git-send-email-isubramanian@apm.com>
 <1415044796-5081-2-git-send-email-isubramanian@apm.com>
 <1420819166.21186.38.camel@citrix.com>
Message-ID: <1420825008.21186.50.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-09 at 15:59 +0000, Ian Campbell wrote:
> I'm running mustang_sw_1.13.29-beta, using the mustang_tianocore_ubt.fd
> method to launch from u-boot.

I realised shortly after that I had downloaded 1.14.14 too, but it
behaves the same.

I rebuilt mustang_tianocore_ubt.fd with the first hunk of this patch and
things now work.

Ian.
