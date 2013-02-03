From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 3 Feb 2013 18:01:50 +0100
Subject: [PATCH v9 00/20] OMAP USB Host cleanup
In-Reply-To: <1358937492-8129-1-git-send-email-rogerq@ti.com>
References: <1358937492-8129-1-git-send-email-rogerq@ti.com>
Message-ID: <20130203170150.GN8476@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Wed, Jan 23, 2013 at 12:37:52PM +0200, Roger Quadros wrote:
> Hi Samuel,
> 
> I think this series is in a pretty good shape to pull now :). I've added
> Reviewed-by and Acked-by tags. You can please pull from below.
> 
> NOTE: the first patch is a stable fix so Greg KH might want to pick it up for 3.8-rc.
> 
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
> 
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
> 
> are available in the git repository at:
>   git://github.com/rogerq/linux.git linux-usbhost14-part
> 
> This patchset addresses the following
> 
> - Consolidate USB Host platform data.
> - Avoid addressing clocks one by one by name and use a for loop + bunch
>   of cleanups.
> - Get number of channels/ports dynamically either from revision register
>   or from platform data. Avoids getting clocks that are not present.
> - Add OMAP5 and HSIC mode (Not tested).
> 
> v9:
> - Addressed clock framework related comments from Russell King.
> - Removed 2 clock data patches from the series as they will be taken care
>   of by Paul Walmsey.
Applied all 20 patches, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
