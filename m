From: joe@perches.com (Joe Perches)
Date: Mon, 11 Feb 2013 16:02:48 -0800
Subject: [PATCH V3 2/2] MAINTAINERS: update Tegra section to capture all
 Tegra files
In-Reply-To: <1360626016-23332-2-git-send-email-swarren@wwwdotorg.org>
References: <1360626016-23332-1-git-send-email-swarren@wwwdotorg.org>
 <1360626016-23332-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360627368.4707.8.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-02-11 at 16:40 -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The intent is to ensure that all Tegra-related patches are sent to the
> linux-tegra@ mailing list, so people can keep up-to-date on all misc
> driver changes.
> 
> Doing this with a keyword is far simpler and more compact than listing
> all Tegra-related drivers, even if wildcards were used.
> 
> Words such as integrate or integrator are common. Ensure the character
> right before "tegra" isn't a-z (case-insensitive), to make sure the
> keyword doesn't match those.
> 
> The only files that the keyword doesn't match are the NVEC driver. Add
> the linux-tegra mailing list to the NVEC entry to solve this.

You should probably add some commentary/documentation
to the K: section description of MAINTAINERS in patch 1/2.

Something about K: patterns also matching filenames.

	K: Keyword perl extended regex pattern to match content in a
	   patch or file.  For instance:
	   K: of_get_profile
	      matches patches or files that contain "of_get_profile"
	   K: \b(printk|pr_(info|err))\b
	      matches patches or files that contain one or more of the words
	      printk, pr_info or pr_err
	   One regex pattern per line.  Multiple K: lines acceptable.
