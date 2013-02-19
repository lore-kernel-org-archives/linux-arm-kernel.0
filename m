From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 16:02:47 -0700
Subject: [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8
 and temp11
In-Reply-To: <1361187031-3679-5-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-5-git-send-email-wni@nvidia.com>
Message-ID: <51240497.8010909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Using macros for the indexes and nrs of temp8 and temp11.
> This make the code much clearer.

Sorry to nit-pick, but those aren't macros, but rather they're enums.

The patch looks good though.
