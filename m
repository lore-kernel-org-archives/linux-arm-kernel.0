From: gregkh@suse.de (Greg KH)
Date: Sun, 17 Apr 2011 23:02:18 -0700
Subject: [PATCH 0/14] Remove sysdev suspend/resume and shutdown operations
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
Message-ID: <20110418060218.GB22168@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 17, 2011 at 11:01:53PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of patches fixes bugs related to the introduction
> of struct syscore_ops later in this cycle, replaces sysdev suspend/resume
> operations in all of the architectures still using them with struct
> syscore_ops-based PM callbacks and finally removes the suspend/resume
> and shutdown operations from struct sysdev_class and struct sysdev_driver.
> 
> Patches [1/14] and [2/14] are important bug fixes targeted at 2.6.39.
> The remaining patches are regareded as 2.6.40 material, but I'd like to
> put them into linux-next shortly, if there are no objections, to catch
> problems that they may introduce before they hit the mainline.  Again,
> if there are no objections I'd like to merge these patches through the
> suspend-2.6 tree.

No objection from me at all, thanks for doing this they look great.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
