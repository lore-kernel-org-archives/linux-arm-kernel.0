From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 9 Apr 2017 09:30:57 +0200
Subject: [PATCH v2 1/3] staging: vc04_services: bcm2835-audio:
 bcm2835-pcm.c Fixed checkpatch warning about unaligned function params
In-Reply-To: <98a8c562937da2a6edc1ab2663ca0ca6c902ab04.1491666884.git.sfaragnaus@gmail.com>
References: <cover.1491666884.git.sfaragnaus@gmail.com>
 <98a8c562937da2a6edc1ab2663ca0ca6c902ab04.1491666884.git.sfaragnaus@gmail.com>
Message-ID: <20170409073057.GA22422@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 05:21:38PM +0100, Andrea della Porta wrote:
> Fixed unaligned function parameters issues, as per checkpatch warning
> 
> Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
> ---
> Changes in v2:
> - subject line more explicit
> - checkpatch output removed as requested, summarized in one line

This does not apply to my tree at all, can you rebase this series
against staging-testing and resend?

thanks,

greg k-h
