From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 11:40:49 -0700
Subject: [PATCH v3 2/6] ARM: tegra: Add chipid, revision and fuse init
In-Reply-To: <1390952176-30402-3-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52F285B1.7030802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
> All fuse related functionality will move to a driver in the following patches.
> To prepare for this, export all the required functionality in a global header
> file and move all users of fuse.h to tegra-soc.h

The patch subject and description don't appear related to each-other.
